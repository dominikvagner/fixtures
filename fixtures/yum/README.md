# Yum

Contains yum repository fixtures

## How to create a yum repository

### 1. Install createrepo
The createrepo tool will create a repomd from a set of packages.
```
dnf install createrepo
```
### 2. Create a package directory
Create a directory with all the packages that will be included in the repository. This directory will become the repository.
```
mkdir ~/path/to/my_repository/
```
### 3. Create the repository
```
createrepo ~/path/to/my_repository/
``` 
This will result in something like this:
```
me@fedora:/path/to/my_repository$ ls; ls repodata/
package1.noarch.rpm  package2.noarch.rpm  repodata
0141395560e56689a07138974c87c8a905144e4ff2b83383863eae75464e402f-primary.xml.zst    ce10291aa41b65b024b190d2b35054e5d8a1e3f7ea6c7bd775cd06fb9906e1dd-other.xml.zst
3c0a966cecd0a3fa853e02e9f0ba284fe6e6b754f441baf0f9f6176409f88fbc-filelists.xml.zst  repomd.xml
```

### 4. (Optional) To add module streams
1. Create a `modules.yaml` file and place it in `~/path/to/my_repository/repodata/`. This must include all the module metadata.

2. Associate the modules with the existing metadata
```
modifyrepo my_repository/repodata/modules.yaml my_repository/repodata/
```

### 5. (Optional) To add comps groups
1. Create a `comps.xml` file and place it in `~/path/to/my_repository/repodata/`. This must include all the comps metadata.

2. Associate the modules with the existing metadata
```
createrepo -g repodata/comps.xml my_repository
```
