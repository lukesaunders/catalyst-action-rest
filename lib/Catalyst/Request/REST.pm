#
# REST.pm
# Created by: Adam Jacob, Marchex, <adam@hjksolutions.com>
# Created on: 10/13/2006 03:54:33 PM PDT
#
# $Id: $

package Catalyst::Request::REST;

use strict;
use warnings;

use Moose;
extends 'Catalyst::Request';
with 'Catalyst::RequestRole::REST';

=head1 NAME

Catalyst::Request::REST - A REST-y subclass of Catalyst::Request

=head1 SYNOPSIS

     if ( $c->request->accepts('application/json') ) {
         ...
     }

     my $types = $c->request->accepted_content_types();

=head1 DESCRIPTION

This is a subclass of C<Catalyst::Request> that adds a few methods to
the request object to faciliate writing REST-y code. Currently, these
methods are all related to the content types accepted by the client.

Note that if you have a custom request class in your application, and it does
not inherit from C<Catalyst::Request::REST>, your application will fail with an
error indicating a conflict the first time it tries to use
C<Catalyst::Request::REST>'s functionality.  To fix this error, make sure your
custom request class inherits from C<Catalyst::Request::REST>.

=head1 METHODS

If the request went through the Deserializer action, this method will
returned the deserialized data structure.

=cut

__PACKAGE__->mk_accessors(qw(data accept_only));

=over 4 

=item accepted_content_types

Returns an array reference of content types accepted by the
client.

The list of types is created by looking at the following sources:

=over 8

=item * Content-type header

If this exists, this will always be the first type in the list.

=item * content-type parameter

If the request is a GET request and there is a "content-type"
parameter in the query string, this will come before any types in the
Accept header.

=item * Accept header

This will be parsed and the types found will be ordered by the
relative quality specified for each type.

=back

If a type appears in more than one of these places, it is ordered based on
where it is first found.

=back

=head1 AUTHOR

Adam Jacob <adam@stalecoffee.org>, with lots of help from mst and jrockway

=head1 MAINTAINER

J. Shirley <jshirley@cpan.org>

=head1 LICENSE

You may distribute this code under the same terms as Perl itself.

=cut

1;
