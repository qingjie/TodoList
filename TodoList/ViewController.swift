//
//  ViewController.swift
//  TodoList
//
//  Created by qingjiezhao on 6/4/15.
//  Copyright (c) 2015 qingjiezhao. All rights reserved.
//

import UIKit

var todos : [TodoModel] = []
var filteredTodos : [TodoModel] = []

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchDisplayDelegate {
    
    @IBOutlet weak var tableView: UITableView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        todos = [
            TodoModel(id: "1", image: "child-selected",title:"1.Go to Playground",date:dateFromString("2015-06-01")!),
            TodoModel(id: "2", image: "shopping-cart-selected", title: "2. Shopping", date: dateFromString("2015-8-28")!),
            TodoModel(id: "3", image: "phone-selected", title: "3. Call", date: dateFromString("2015-9-30")!),
            TodoModel(id: "4", image: "travel-selected", title: "4. Travel to Europe", date: dateFromString("2015-10-31")!)
        ]
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
        var contentOffset  = tableView.contentOffset
        contentOffset.y += searchDisplayController!.searchBar.frame.size.height
        tableView.contentOffset = contentOffset
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == searchDisplayController?.searchResultsTableView{
            return filteredTodos.count
        }else{
            return todos.count
        }
        
    }
    
    //Mark-UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = self.tableView.dequeueReusableCellWithIdentifier("todoCell") as! UITableViewCell
        
        var todo :  TodoModel
        if tableView == searchDisplayController?.searchResultsTableView{
            todo = filteredTodos[indexPath.row] as TodoModel
        }else{
            todo = todos[indexPath.row] as TodoModel
        }
        
        
        
        var image  = cell.viewWithTag(101) as? UIImageView
        var title = cell.viewWithTag(102) as? UILabel
        var date = cell.viewWithTag(103) as? UILabel
        
        image?.image = UIImage(named: todo.image)
        title?.text = todo.title
        
        let locale = NSLocale.currentLocale()
        let dateFormat = NSDateFormatter.dateFormatFromTemplate("yyyy-MM-dd", options: 0, locale: locale)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat
        date?.text = dateFormatter.stringFromDate(todo.date)
        
        return cell
    }
 
    
    //Mark-UITableViewDelegate
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == UITableViewCellEditingStyle.Delete{
            todos.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    //EditMode
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }
    
    
    //Mark_MoveCell
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        return editing
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath){
        let todo = todos.removeAtIndex(sourceIndexPath.row)
        todos.insert(todo, atIndex:destinationIndexPath.row)
    }
    
    //Mark_Search
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool{
        filteredTodos = todos.filter(){$0.title.rangeOfString(searchString) != nil}
        return true
    }
    
    //unwind
    @IBAction func close(segue: UIStoryboardSegue) {
        println("closed")
        tableView.reloadData()
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditTodo" {
            var vc = segue.destinationViewController as! DetailViewController
            var indexPath = tableView.indexPathForSelectedRow()
            if let index = indexPath {
                vc.todo = todos[index.row]
            }
        }
    }
}

