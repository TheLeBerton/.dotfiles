#!/usr/bin/zsh
#
##mkcpp <ClassName> [directory]
mkcpp() {
	if [[ -z "$1" ]]; then
		echo "Usage: mkcpp <ClassName> [directory]"
		return 1
	fi

	local class="$1"
	local dir="${2:-.}"
	local upper="${(U)class}"
	local cpp="$dir/$class.cpp"
	local hpp="$dir/$class.hpp"

	if [[ "$dir" != "." && ! -d "$dir" ]]; then
		mkdir -p "$dir"
	fi

	if [[ -e "$hpp" || -e "$cpp" ]]; then
		echo "Error: $hpp or $cpp already exists."
		return 1
	fi

	cat > "$hpp" <<EOF
#ifndef ${upper}_HPP
# define ${upper}_HPP

class $class
{
public:
	$class();
	$class(void param1);
	$class(const $class &other);
	$class &operator=(const $class &other);
	~$class();

private:
};

#endif
EOF

	cat > "$cpp" <<EOF
#include "$class.hpp"
$class::$class()
{
}

$class::$class(void param1)
{
}

$class::$class(const $class &other)
{
	*this = other;
}

$class &$class::operator=(const $class &other)
{
	if (this != &other)
	{
	}
	return (*this);
}

$class::~$class()
{
}
EOF

	echo "Created: $hpp"
	echo "Created: $cpp"
}
