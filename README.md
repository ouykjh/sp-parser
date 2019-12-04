# sp-parser
Sp-parser is a simple log parser.

## Technology

Ruby 2.6.1

## Run
Run 
`ruby ./parser.rb <path-to-log-file>`
from `lib` directory

## Solution

`parser.rb` - main file, which parser commnand line args, execute log parsing and display output data

`parser_service.rb` - service which contains main logic of parsing data, it requires injection of log stream parser, 
it makes solution more flexible if we want to parse logs from different source for example IOStream. For better efficency it uses
Set for storing unique ips.

`file_parser.rb` - parsing file input, it takes block for manipulating data, it respond to parse method as all stream parsers should
to be compatible with `parser_service` (in future if there will be more stream parsers is recommende to use parent abstract class to
keep common interface.

### Tests
There are to types of tests: features and unit test. Unit tests testing small, separated parts of application (methods, classes)
when features are more integration tests to simulate application use cases.
