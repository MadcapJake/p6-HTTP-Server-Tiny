use v6;

use HTTP::Server::Tiny;

my $port = 15555;

HTTP::Server::Tiny.new(host => '127.0.0.1', port => $port).run(sub ($env) {
    my $channel = Channel.new;
    start {
        for 1..100 {
            $channel.send(($_ ~ "\n").Str.encode('utf-8'));
        }
        $channel.close;
    };
    return 200, ['Content-Type' => 'text/plain'], $channel
});

