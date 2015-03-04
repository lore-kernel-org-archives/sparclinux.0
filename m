From: David Miller <davem@davemloft.net>
Date: Wed, 04 Mar 2015 20:35:38 +0000
Subject: Re: [PATCH v2 0/2] sparc: IOMMU pools for better scalability
Message-Id: <20150304.153538.2222090092336261936.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150303142202.GA7696@oracle.com>
In-Reply-To: <20150303142202.GA7696@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Ahern <dsahern@gmail.com>
Date: Wed, 04 Mar 2015 12:32:32 -0700

> On 3/4/15 12:15 PM, David Miller wrote:
>> From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
>> Date: Wed, 4 Mar 2015 14:10:17 -0500
>>
>>> On (03/03/15 17:15), David Miller wrote:
>>>> Please don't put "ifdef notyet" kind of stuff into your changes,
>>>> that is not appropriate.  In any event, I want you to translate all
>>>> of the PCI DMA implementations, because it is the only way you can
>>>> show me that your abstractions are sufficient.
>>>
>>> That means I have to fix all kinds of dinosaurs in the neighborhood,
>>> things like pci_fire, pci_schizo, pci_psycho, sun4u. Some of this
>>> hardware was EOL'ed a long time ago. And the last time I remember
>>> using a sun4u was back in 2008 (and even then, it was really not
>>> very useful for any sort of non-trivial SMP/perf development).
>>>
>>> But whatever floats your boat.
>>
>> It's a conversion that has to be done anyways, and otherwise you'll
>> have no idea whether your abstractions are sufficient or not.
> 
> Doesn't that run the risk of breaking older platforms, which cannot
> realistically be tested? Why not refactor the code such that old
> platforms are not touched and focus on abstractions for modern h/w?

Are you kidding me?  I have a sun4u sitting right under my desk, and
several more (all IOMMU variants) at my Seattle house, I'll test it
for you.
