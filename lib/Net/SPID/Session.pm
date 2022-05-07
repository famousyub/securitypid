package Net::SPID::Session;
use Moo;

has 'idp_id'        => (is => 'ro', required => 1);
has 'nameid'        => (is => 'ro', required => 1);
has 'session_index' => (is => 'ro', required => 1);
has 'assertion_xml' => (is => 'ro', required => 1);
has 'level'         => (is => 'ro', required => 1);
has 'attributes'    => (is => 'ro', default => sub { {} });

1;

=head1 SYNOPSIS

    use Net::SPID;
    
    # initialize our SPID object
    my $spid = Net::SPID->new(...);
    
    # parse a response from an Identity Provider
    my $assertion = eval {
        $spid->parse_assertion($saml_response_xml, $authnreq_id);
    };
    
    # get a Net::SPID::Session object (serializable for later reuse, such as logout)
    my $session = $assertion->spid_session;

=head1 ABSTRACT

This class represents a SPID session. It encapsulates the assertion and its most important data (nameid, session number, attributes) for later reuse, including for logout purposes.

=head1 CONSTRUCTOR

This class is not supposed to be initialized directly. It can be generated by calling the L<Net::SPID::SAML::In::Response/spid_session> method.

=head1 METHODS

=head2 idp_id

This method returns the entityID of the Identity Provider which emitted the assertion (and to which any logout request must go).

=head2 nameid

This method returns the subject identifier as returned in the assertion.

=head2 session_index

This method returns the session identifier as returned in the assertion.

=head2 assertion_xml

This method returns the raw XML of the assertion.

=head2 level

The SPID level authenticated by the Identity Provider. You may want to check this value as it might be equal or higher than the one you requested.

=head2 attributes

This method returns a hashref containing the attributes.

=cut
