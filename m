From: James Hogan <james.hogan@imgtec.com>
Date: Tue, 13 Nov 2012 09:21:00 +0000
Subject: Re: [PATCH] Centralise CONFIG_ARCH_NO_VIRT_TO_BUS
Message-Id: <50A210FC.4070007@imgtec.com>
List-Id: <sparclinux.vger.kernel.org>
References: <ADE657CA350FB648AAC2C43247A983F00206B25884B1@AUSP01VMBX24.collaborationhost.net> <CAErSpo6WG2R_8sa=rOmAOci-3iFpDs2NFzNkZYxDnD2oTiMQJg@mail.gmail.com> <20121113082615.2f482eb8835daf46e1f27947@canb.auug.org.au>
In-Reply-To: <20121113082615.2f482eb8835daf46e1f27947@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, H Hartley Sweeten <hartleys@visionengravers.com>, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/11/12 21:26, Stephen Rothwell wrote:
> Make if easier for more architectures to select it and thus
> disable drivers that use virt_to_bus().
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Reviewed-by: James Hogan <james.hogan@imgtec.com>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQohD8AAoJEKHZs+irPybf82gP/Az9f+Q5Vn/fGkQwOOpfsxsl
hpZGzIc7P6/ZU6IFWxN8hAKdJjOBH/ko0r+LMoczlQzlhlFd+qpDU+i2tZBqbp/G
S+4w56J/PC5MtZFlUEh68e0H313Mgt9kK8vy4yVnzBTvIgGsJuXjeK4qQSKBm3LP
LguU2AONT8GCfT8DRm9sbdS+WcXnBjRWeUkm8pZ+UX8kEe7ryaccidwvR16aP9l1
zx4HwFW0nCLYxwSOVQg2hi2pQyHD5sqFeLEYNbvEPlGleRKNJtz3bnYWbRdPkO2D
CoRjiSw5/iCd/SghvwEKdkJFkOw4zdONElrBvsYXqn3QsFFpyYal43gyKIgPkSb6
s5OdTJ1ScS3IgtxFpQ1nfj020rS1ieM8eY/bXyuGPEZzwbe0moe+g64Qye9nEutn
7oWKoue1H8uRaJ46WoD22bjG7SezLycDnAlG6ujo75qyxeBcVJ9ZB6DxHPnEU02M
P0sA8FLTFmzigRV2TBKBZbh3NrFGEi/riMA8U9f9XfLkxt7zdXGTvJ45C91U8HjT
3uQffRL/WBOQOILXtEFzf22DSPeoRklvyZmlHBsmNC6AYhSDnOvpUfOThaetQaFe
voiFdDZhtxdk20l0DpReeAUBVUFOjBjh6NzWLZbVdrfgHrpndw7s7jjfy/e5vhDU
wI2jW7slxuwARtv3Q1CV
=XvmD
-----END PGP SIGNATURE-----

