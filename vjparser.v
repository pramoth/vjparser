module main
//import data
import os
import classdef



fn main() {
	path := 'src/test/main.class'
	class_contents := os.read_bytes(path) or {
		println('failed to open $path')
		return
	}
	mut class_file := classdef.ClassFile{}
	mut cp_info := classdef.ClassInfo{}
	cp_info.tag = .utf8

	class_file.magic = u32(class_contents[0]<< 24 | class_contents[1]<< 16 | class_contents[2]<< 8 | class_contents[3])
	class_file.minor_version = u16(class_contents[4] << 8 | class_contents[5])
	class_file.major_version = u16(class_contents[6] << 8 | class_contents[7])
	class_file.constant_pool_count = u16(class_contents[8] << 8 | class_contents[9])
	mut next_tag := 9
	for i := 0 ;i < class_file.constant_pool_count ; i++ {
		next_tag = next_tag+1
		cp_info.tag =  class_contents[next_tag]
		match  cp_info.tag {
			.method_ref { next_tag = parse_method_field_interface_method_ref(class_contents,next_tag) }
			.field_ref { next_tag = parse_method_field_interface_method_ref(class_contents,next_tag) }
			.interface_method_ref { next_tag = parse_method_field_interface_method_ref(class_contents,next_tag) }
			.string_tag { next_tag = parse_string(class_contents,next_tag) }
			.utf8 { next_tag = parse_utf(class_contents,next_tag) }
			.class { next_tag = parse_class(class_contents,next_tag) }
			else {println('should not happen.${cp_info.tag}')}
		}
	}
	println('magicnumber : ${class_file.magic:X}')
	println('minor version : ${class_file.minor_version:X}')
	println('major version : ${class_file.major_version:X}')
	println('conts_pool_count : ${class_file.constant_pool_count}')
	println('cp_info.tag : ${cp_info.tag}')

}
fn parse_method_field_interface_method_ref(class_contents []byte,offset int) int{
	class_index := class_contents[offset+1] << 8 | class_contents[offset+2] 
	name_and_type_index := class_contents[offset+3] << 8 | class_contents[offset+4] 
	println('method_ref class_index : ${class_index}')
	println('method_ref name_and_type_index : ${name_and_type_index}')
	return offset + 4
}
fn parse_string(class_contents []byte,offset int) int{
	string_index := class_contents[offset+1] << 8 | class_contents[offset+2] 
	//bytes :=  class_contents[offset+3 .. length]
	println('parse_string string_index : ${string_index}')
	//println('parse_utf : ${bytes}')
	return offset + 2
}

fn parse_utf(class_contents []byte,offset int) int{
	length := class_contents[offset+1] << 8 | class_contents[offset+2] 
	bytes :=  class_contents[offset+3 .. offset+3+length]
	println('parse_utf length: ${length}')
	println('parse_utf : ${bytes}')
	return offset + 2 + length
}

fn parse_class(class_contents []byte,offset int) int{
	name_index := class_contents[offset+1] << 8 | class_contents[offset+2] 
	println('parse_class name_index : ${name_index}')
	return offset + 2
}