#TransXChange to GTFS 

A rather crude implementation of a TransXChange to GTFS converter written in Objective-C. It needs a *lot* of work, but the basics are there. It's ultimately intended to be used a command line tool in the import process of the Transporter API.

[TransXChange](https://www.gov.uk/government/collections/transxchange) is the UK standard for publishing transportation data. TransXChange, whilst comprehensive, is tricky to parse and even trickier to understand. [GTFS](https://developers.google.com/transit/gtfs/) (General Transit Feed Specification) is a CSV based transit format which is much easier to parse and query.  

## Known Issues 

- Needs a UI / command to import documents 
- Doesn't factor in public holidays 
- No examples / poor documentation. 

## Maintainers 

- [Phillip Caudell](http://phillipcaudell.com) [(@phillipcaudell)](http://twitter.com/phillipcaudell)


## License 

Lightning Table is available under the MIT license. See the LICENSE file for more info.