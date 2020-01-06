import 'dart:io';

String fixtures(String name)=> File('test/fixtures/$name').readAsStringSync();