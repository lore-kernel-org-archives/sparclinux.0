From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 14 Feb 2010 14:06:28 +0000
Subject: Re: [PATCH 3/9] of: protect linux/of.h with CONFIG_OF
Message-Id: <fa686aa41002140606s798f356ft6dcea472f7076bdd@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100213154838.4767.83881.stgit@angua> <20100213160242.4767.57641.stgit@angua>
	<1266127834.16346.60.camel@pasglop>
In-Reply-To: <1266127834.16346.60.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: monstr@monstr.eu, sfr@canb.auug.org.au, jeremy.kerr@canonical.com, davem@davemloft.net, microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org

On Sat, Feb 13, 2010 at 11:10 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sat, 2010-02-13 at 09:02 -0700, Grant Likely wrote:
>> From: Jeremy Kerr <jeremy.kerr@canonical.com>
>>
>> For platforms that have CONFIG_OF optional, we need to make the contents
>> of linux/of.h conditional on CONFIG_OF.
>>
>> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> For now...
>
> In the long run, maybe we want some of the iterators to be empty inlines
> returning NULL ?

Yes.  I'll add them as they are needed.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
