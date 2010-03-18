From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 18 Mar 2010 17:07:35 +0000
Subject: Re: [V2 PATCH 06/10] of/drivers: Always use struct device.of_node to
Message-Id: <fa686aa41003181007k9202cd6n44d2d3997ef626a1@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100318144836.21082.93040.stgit@angua>
	<20100318152238.21082.10985.stgit@angua>
	<20100318125939.2b39d7f2@lappy.seanm.ca>
In-Reply-To: <20100318125939.2b39d7f2@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Sean MacLennan <smaclennan@pikatech.com>
Cc: linux-kernel@vger.kernel.org, michal.simek@petalogix.com, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Thu, Mar 18, 2010 at 10:59 AM, Sean MacLennan
<smaclennan@pikatech.com> wrote:
> On Thu, 18 Mar 2010 09:22:39 -0600
> Grant Likely <grant.likely@secretlab.ca> wrote:
>
>> The following structure elements duplicate the information in
>> 'struct device.of_node' and so are being eliminated. =A0This patches
>> makes all readers of the following elements use device.of_node
>> instead.
>
> The NDFC driver also needs a patch... or at least the version from your
> last of_patch set does. I am included the patch I needed to get it to
> compile.

Thanks Sean, I've added this patch to my series.  s-o-b line please?

g.
