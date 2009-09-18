package Champlain;

=head1 NAME

Champlain - Map rendering canvas

=head1 SYNOPSIS

	use Clutter '-init';
	use Champlain;
	
	# Standard clutter canvas
	my $stage = Clutter::Stage->get_default();
	$stage->set_size(800, 600);
	
	# Create the map view and set some properties
	my $map = Champlain::View->new();
	$map->set('scroll-mode', 'kinetic');
	$map->set_size($stage->get_size);
	$map->set_property('zoom-level', 7);
	$map->center_on(45.466, -73.75);
	
	# Pack the actors	
	$stage->add($map);
	$stage->show_all();
	
	# Main loop
	Clutter->main();

=head1 DESCRIPTION

Champlain is a Perl binding for the C library libchamplain which provides a
canvas widget based on Clutter that displays maps from various free map sources
such as I<OpenStreetMap>, I<OpenAerialMap> and I<Maps for free>.

If the C library is compiled with GTK support then the map widget can also be
embedded in any GTK application.

For more information about libchamplain see:
L<http://projects.gnome.org/libchamplain/>.

=head1 EXPORTS

The library makes the following constants available:

=over

=item MIN_LAT

=item MAX_LAT

=item MIN_LONG

=item MAX_LONG

=back

The tag I<coords> can be used for importing the constants providing the minimal
and maximal values for (latitude, longitude) coordinates:

	use Champlain ':coords';

=head1 BUGS

The library libchamplain is quite young and its API is changing as the code
gains maturity. These bindings try to provide as much coverage from the C
library as possible. Don't be surprised if the API changes within the next
releases this is normal as B<libchamplain IS NOT yet API nor ABI frozen>.

It's quite probable that bugs will be exposed, please try to report all bugs
found through GNOME's Bugzilla
L<http://bugzilla.gnome.org/simple-bug-guide.cgi?product=champlain> (when
prompted for a component simply choose I<bindings>). GNOME's bug tracking tool
is preferred over RT because the bugs found in the library could impact
libchamplain or the other bindings. Of course all bugs entered through RT will
be acknowledged and addressed.

=head1 AUTHORS

Emmanuel Rodriguez E<lt>potyl@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Emmanuel Rodriguez.

This library is free software; you can redistribute it and/or modify
it under the same terms of:

=over 4

=item the GNU Lesser General Public License, version 2.1; or

=item the Artistic License, version 2.0.

=back

This module is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

You should have received a copy of the GNU Library General Public
License along with this module; if not, see L<http://www.gnu.org/licenses/>.

For the terms of The Artistic License, see L<perlartistic>.

=cut

use warnings;
use strict;

our $VERSION = '0.07';

use base 'DynaLoader';
use Exporter 'import';

use Clutter;

use constant {
	MIN_LAT  => -90,
	MAX_LAT  =>  90,
	MIN_LONG => -180,
	MAX_LONG =>  180,
};


our %EXPORT_TAGS = (
	coords => [qw(MIN_LAT MAX_LAT MIN_LONG MAX_LONG)],
	maps => [qw(
		MAP_OSM_MAPNIK
		MAP_OSM_OSMARENDER
		MAP_OSM_CYCLE_MAP
		MAP_OAM
		MAP_MFF_RELIEF
	)],
);

our @EXPORT_OK = map { @{ $_ } } values %EXPORT_TAGS;


sub MAP_OSM_MAPNIK {
	return Champlain::MapSourceFactory->OSM_MAPNIK;
}

sub MAP_OSM_OSMARENDER {
	return Champlain::MapSourceFactory->OSM_OSMARENDER;
}

sub MAP_OSM_CYCLE_MAP {
	return Champlain::MapSourceFactory->OSM_CYCLE_MAP;
}

sub MAP_OAM {
	return Champlain::MapSourceFactory->OAM;
}

sub MAP_MFF_RELIEF {
	return Champlain::MapSourceFactory->MFF_RELIEF;
}


sub dl_load_flags { $^O eq 'darwin' ? 0x00 : 0x01 }

__PACKAGE__->bootstrap($VERSION);

1;
