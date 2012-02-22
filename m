From: David Miller <davem@davemloft.net>
Date: Wed, 22 Feb 2012 20:44:17 +0000
Subject: Re: OF-related boot crash in 3.3.0-rc3-00188-g3ec1e88
Message-Id: <20120222.154417.1110838022563953071.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120221010537.GA15898@dhcp-172-17-108-109.mtv.corp.google.com>
	<alpine.SOC.1.00.1202220213180.4171@math.ut.ee>
	<20120222174825.GA32694@google.com>
In-Reply-To: <20120222174825.GA32694@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: tj@kernel.org
Cc: mroos@linux.ee, grant.likely@secretlab.ca, rob.herring@calxeda.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, sam@ravnborg.org

From: Tejun Heo <tj@kernel.org>
Date: Wed, 22 Feb 2012 09:48:25 -0800

> On Wed, Feb 22, 2012 at 02:36:13AM +0200, Meelis Roos wrote:
>> > Meelis, can you please apply the following patch before & after the
>> > offending commit, boot with "memblock=DEbug" added as kernel param and
>> > post the boot log?  The patch will generate some offset warnings after
>> > the commit but should work fine.
>>=20
>> Before the commit (v3.2-rc3-75-g0ee332c): memblock1.gz (attached)
>> After the commit (v3.2-rc3-76-g7bd0b0f): memblock2.gz (attached)
>=20
> Can you please try the following patch?  If it still fails to boot,
> please attach the failing log.  Thank you.

Interesting, but two things strike me.

First, this seems like it would only cause problems if the caller
specified a too small size parameter, and then wrote past the 'size'
bytes of the buffer.  And if so, this means we have an improperly
sized allocation somewhere, probably in the OF tree fetching code.

For example, maybe we mis-calculate the size of an OF device node
property before we fetch it from the firmware, therefore allocate
too small a buffer, and the property fetch operation splats all
over the end of the buffer.  Another possibility is that the
property length reported by the firmware is wrong and too small.

BTW, this kind of bug would be easy to catch, simply put a magic
number signature into all unallocated memblock memory then at
allocation time check that signature.  If we signal an error when we
don't see the proper signature and turn on the OF tree building
logging, we can see exactly which operation writes past the end of a
buffer.

Second, you'd need similar handling in other call chains such as
memblock_double_array()'s invocation of memblock_find_in_range().
It seems a bad idea to hide how size is modified, so probably it's
best to pass the address of the size parameter and modify the
caller's value in that way so that the size used in the reserve
matches up.
