# Roadmap

## Next version

* rebuild store using pouchdb
  * Use simple documents   
    * id == name
    * stars
    * pushed_at
    * category
  * Use seperate, simple documents for sortBy
    * stars
      * id == stars
      * name
    * pushed_at
      * id == pushed_at
      * name
  * fetch additional data (dependencies, summary) from remotes 
* Remove deprecated CocoaPod from local database

## Future versions

* Sorting by Activity via GitHub commit statistics
* Search in top navigation with auto-completion
  1. Categories
  2. CocoaPods
* Statistics (?)
* Sorting (?)
* Performance
  * Create binary files in Seeds (?)
  * Move work to worker (fetch index, search, render html, ...?)
* Categorization system closer to each of the repositories
* Screenshots for UI-based CocoaPods (?)
* Use brunch with a deploy task instead of Rails
