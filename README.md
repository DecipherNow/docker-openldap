# docker-nexus

A Docker image for OpenLDAP.

## Running

In development and test environments, it is often sufficient to run:

        docker run -p 8389:8389 decipher/openldap:<tag>

If you wish to perist directory data across restarts you will need to mount a volume at `/var/lib/openldap`.

        docker run -p 8389:8389 -v ${PWD}/openldap:/var/lib/openldap decipher/openldap:<tag>

Additionally, this image supports configuration via a number of environment variables.

| Variable               | Default                   | Description                               |
|------------------------|---------------------------|-------------------------------------------|
| ROOT_DN                | cn=root,dc=example,dc=com | The distinguished name of the root entry. |
| ROOT_PW                | password                  | The password for the root entry.          |
| ROOT_SUFFIX            | dc=example,dc=com         | The root suffix for the directory.        |
| TLS_CA_CERTIFICATE     | *Base64 TLS Certificate*  | The base64 encoded CA certificate.        |
| TLS_SERVER_CERTIFICATE | *Base64 TLS Certificate*  | The base64 encoded server certificate.    |
| TLS_SERVER_KEY         | *Base64 TLS Key*          | The base64 encoded server key.            |

Lastly, the TLS certificates and keys may be mounted directly and this will override the environment variables above.

| Mount                        | Description             |
|------------------------------|-------------------------|
| /etc/openldap/tls/ca.crt     | The CA certificate.     |
| /etc/openldap/tls/server.crt | The server certificate. |
| /etc/openldap/tls/server.key | The server key.         |

## Using

Once running the LDAP server can be reached at ldap://localhost:8389/:

        ldapwhoami -D cn=root,dc=example,dc=com -w password -H ldap://localhost:8389/ -ZZ

## Building

To build the image run:

        ./build.sh

## Publishing

To build and publish the image run:

        ./publish.sh


## Contributing

1. Fork it
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create new Pull Request
