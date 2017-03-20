# Building the image
run the build script : `./build "image-tag"`
where "image-tag" can be anything because it is only going to be used as a Tag name for the Image.

# Running a container
run the execution script : `./run "image-tag" ["container-name"] ["domain-name"]`
+ "container-name" : Optionally sets a container name for easy referencing. Default is "postfix".
+ "domain-name" : Optionnaly sets a domain name for the Postfix installation. Default is "fy-computing.local"
+ For now, this script uses "mailserver" as a default hostname for the created container.
