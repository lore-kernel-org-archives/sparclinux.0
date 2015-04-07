From: Yinghai Lu <yinghai@kernel.org>
Date: Tue, 07 Apr 2015 05:23:06 +0000
Subject: Re: [PATCH 3/3] PCI: Set pref for mem64 resource of pcie device
Message-Id: <CAE9FiQVguGRDbYxRW=KNW6ZnUE23ifHJN4WXrf03JZB_P+d21w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
	<1427857069-6789-4-git-send-email-yinghai@kernel.org>
	<20150406220638.GH10892@google.com>
	<CAE9FiQWz_VYOmrN+L3nAAmA7OqZdAYawwku2A09RVrNObQn4jQ@mail.gmail.com>
	<20150406224913.GI10892@google.com>
	<CAE9FiQWGqjyp9YABc=BvzFSm7Tj7reojOoMPDybQZ1RYXD8XZQ@mail.gmail.com>
	<CAErSpo6au3nWwNJCQBOLV=9=5Jy5=MKnky4LLjThKf8J7MJfdg@mail.gmail.com>
In-Reply-To: <CAErSpo6au3nWwNJCQBOLV=9=5Jy5=MKnky4LLjThKf8J7MJfdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Miller <davem@davemloft.net>, David Ahern <david.ahern@oracle.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

On Mon, Apr 6, 2015 at 8:43 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Apr 6, 2015 at 8:13 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Mon, Apr 6, 2015 at 3:49 PM, Bjorn Helgaas <bhelgaas@google.com> wrot=
e:
>>>
>>> For "[PATCH 1/3] PCI: Introduce pci_bus_addr_t", I'm waiting for an upd=
ated
>>> version with Kconfig tweaks so we don't break other arches.
>>
>> I was thinking that you will update it manually.
>
> I asked you for an updated version, incorporating the documentation
> updates, to make sure I got everything you intended.  But I did go
> ahead and do it manually for you.

Good.

http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=3Dfor=
-linus&id=F70899ff889a38f9697d3c153aaacaed25f501c3

Please consider to split that into two patches.
First one include changes in : include/linux/types.h and
Documentation/DMA-API-HOWTO.txt.
and you should be author for that.


>
>>> For "[PATCH 2/3] sparc/PCI: Add mem64 resource parsing for root bus", I=
'm
>>> waiting for a version that fixes the other of_bus_pci_get_flags() and
>>> pci_parse_of_flags() implementations at the same time (or an explanation
>>> about why we should fix only the arch/sparc version).  I don't want to =
fix
>>> one place and leave the same bug in other places.
>>
>> I don't even know if other arch like powerpc support 64-bit bus address.
>>
>> No one from powerpc reported a problem, why should we mess it up now?
>>
>> I would like to see someone get access those three kinds of machine that=
 support
>> of to unify of support code.
>
> Of course changes there should be tested on all the affected machines.
> I opened https://bugzilla.kernel.org/show_bug.cgi?id=96241 and
> assigned it to you as a reminder that there is nearly identical code
> in several other places that may have the same issue.

ok, will on that to have three patches cover them.

>
> I pushed these two changes to for-linus.  I'll work on the third
> tomorrow.  The current changelog is very sparc64-centric, and it needs
> to be much more explicit about how the change will affect every arch.

Sure. That will affect all platform.

Thanks

Yinghai
