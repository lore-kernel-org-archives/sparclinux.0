From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 14 Feb 2012 02:41:48 +0000
Subject: Re: OF-related boot crash in 3.3.0-rc3-00188-g3ec1e88
Message-Id: <CACxGe6vp-a1TC_zMaOW+XE9WeYtgAS7X-HDyf7uxYZPKLzEkVQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120213080618.GA11077@ponder.secretlab.ca> <alpine.SOC.1.00.1202131119040.1488@math.ut.ee>
 <20120213214623.GJ11077@ponder.secretlab.ca> <20120213.195835.1573147101037168145.davem@davemloft.net>
 <CACxGe6tqsYs8-n2Q+EGGekS6wOOYYXUvUbEu6sfQ7U3--Gyjnw@mail.gmail.com>
In-Reply-To: <CACxGe6tqsYs8-n2Q+EGGekS6wOOYYXUvUbEu6sfQ7U3--Gyjnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: mroos@linux.ee, rob.herring@calxeda.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Feb 13, 2012 at 7:30 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> On Mon, Feb 13, 2012 at 5:58 PM, David Miller <davem@davemloft.net> wrote:
>> From: Grant Likely <grant.likely@secretlab.ca>
>> Date: Mon, 13 Feb 2012 14:46:23 -0700
>>
>>> Ugh; that looks bad. =A0If it failed there, then the global device node=
 list
>>> is corrupted. =A0I hate to ask you this, but would you be able to git b=
isect to
>>> narrow down the commit that causes the problem?
>>
>> Wild guess on all of these bugs, bad OF node reference counting and a
>> OF node is free'd up prematurely.
>>
>> If you look at the sparc code that has been subsumed into the generic
>> drivers/of/ stuff over the past few years, you'll see that we never
>> consistently did any of the reference counting bits on the sparc side.
>
> Hmmm.... The of_node_put() code path shouldn't exist on sparc. =A0You'll
> see that it is #ifdef'd out in include/linux/of.h. =A0Plus, only
> 'OF_DETACHED' nodes are allowed to be released, an there are only 3
> code paths (all calling of_detach_node()) specific to powerpc that can
> detach a node.

In fact, I should disable those paths always when CONFIG_OF_DYNAMIC is
disabled.  I'll look into doing so for v3.4.

g.
