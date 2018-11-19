From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Date: Mon, 19 Nov 2018 20:30:46 +0000
Subject: Re: [PATCH net-next 2/6] net/bpf: split VLAN_PRESENT bit handling from VLAN_TCI
Message-Id: <20181119203046.GA7067@qmqm.qmqm.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
 <b7fed809fc44d0b439adeb69d0fe98dd036b05e8.1541876179.git.mirq-linux@rere.qmqm.pl>
 <c420b7a8-73df-3e9c-962a-a295ad0a6139@iogearbox.net>
In-Reply-To: <c420b7a8-73df-3e9c-962a-a295ad0a6139@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Paul Burton <paul.burton@mips.com>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org

On Mon, Nov 19, 2018 at 12:26:46PM +0100, Daniel Borkmann wrote:
> On 11/10/2018 07:58 PM, Micha=B3 Miros=B3aw wrote:
> > Signed-off-by: Micha=B3=A0Miros=B3aw <mirq-linux@rere.qmqm.pl>
>=20
> Why you have empty commit messages for non-trivial changes like this in
> 4 out of 6 of your patches ...
>=20
> How was it tested on the JITs you were changing? Did you test on both,
> big and little endian machines?

I have only x86 boxes currently so didn't try to test others. I hope
upstreaming the series through net-next will allow us to find any
fallouts, if any. The changes are very simple, though: they move
code around (the "splitting" part) and eventually change a vlan_present
flag's position in a skbuff structure. Dependency on CPU endianness is
removed by using byte loads for the flag.

Best Regards,
Micha=B3 Miros=B3aw
