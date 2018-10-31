### Makinoa

Simple build system for C projects for Generation III Pokemon ROM Hacks.

Licensed under the Simplified BSD License.

#### Dependencies

* A recent version of Python 3
* devkitARM and a `DEVKITARM` environment variable with the directory it was installed to.
* Armips and a `ARMIPS` environment variable with the path of the armips binary.

#### Usage

`python3 path/to/makinoa directory`

The directory is actually optional; if it isn't provided, it will be assumed to be the current working directory. If the project built without errors, you will get no output at all (otherwise, you will see the errors).

For example, if the root of the C project has a `scripts` directory which itself contains `makinoa`, you would run `python3 scripts/makinoa` from the project root.
