module classdef

pub enum ClassInfoTag{
	utf8 = 1
	integer = 3
	float = 4
	long = 5
	double = 6
	class = 7
	string_tag = 8
	field_ref = 9
	method_ref = 10
	interface_method_ref = 11
	name_and_type = 12
	method_handle = 15
	mmethod_type = 16
	invoke_dynamic = 18

}
pub struct ClassInfo{
	pub mut:
		tag ClassInfoTag
		name_index u16
}

pub struct MethodrefInfo {
    pub mut:
		tag ClassInfoTag
		class_index u16
		name_and_type_index u16
}
pub struct FieldrefInfo {
    pub mut:
		tag ClassInfoTag
		class_index u16
		name_and_type_index u16
}

pub struct InterfaceMethodrefInfo {
    pub mut:
		tag ClassInfoTag
		class_index u16
		name_and_type_index u16
}
pub struct StringInfo {
    pub mut:
		tag ClassInfoTag
		string_index u16
}
pub struct NameAndTypeInfo{

}
pub struct Utf8Info {
	pub mut:
		tag ClassInfoTag
		length u16
		bytes []byte
}

pub struct IntegerInfo {
    pub mut:
		tag ClassInfoTag
		bytes u32
}
pub struct FloatInfo {
    pub mut:
		tag ClassInfoTag
		bytes u32
}

pub struct ClassFile{
	pub mut :
		magic u32
		minor_version u16
		major_version u16
		constant_pool_count u16
	/**
    cp_info        constant_pool[constant_pool_count-1];
    u2             access_flags;
    u2             this_class;
    u2             super_class;
    u2             interfaces_count;
    u2             interfaces[interfaces_count];
    u2             fields_count;
    field_info     fields[fields_count];
    u2             methods_count;
    method_info    methods[methods_count];
    u2             attributes_count;
    attribute_info attributes[attributes_count];
	**/
}

