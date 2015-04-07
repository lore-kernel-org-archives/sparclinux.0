From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 07 Apr 2015 12:18:25 +0000
Subject: Re: [PATCH 3/3] PCI: Set pref for mem64 resource of pcie device
Message-Id: <CAErSpo5tve=YV+iYAXQUu6qkb7WWt40Bpb3R6tF=Hj5AzY+-_g@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
 <1427857069-6789-4-git-send-email-yinghai@kernel.org> <20150406220638.GH10892@google.com>
 <CAE9FiQWz_VYOmrN+L3nAAmA7OqZdAYawwku2A09RVrNObQn4jQ@mail.gmail.com>
 <20150406224913.GI10892@google.com> <CAE9FiQWGqjyp9YABc=BvzFSm7Tj7reojOoMPDybQZ1RYXD8XZQ@mail.gmail.com>
 <CAErSpo6au3nWwNJCQBOLV=9=5Jy5=MKnky4LLjThKf8J7MJfdg@mail.gmail.com> <CAE9FiQVguGRDbYxRW=KNW6ZnUE23ifHJN4WXrf03JZB_P+d21w@mail.gmail.com>
In-Reply-To: <CAE9FiQVguGRDbYxRW=KNW6ZnUE23ifHJN4WXrf03JZB_P+d21w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>, David Ahern <david.ahern@oracle.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

On Tue, Apr 7, 2015 at 12:23 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Mon, Apr 6, 2015 at 8:43 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Mon, Apr 6, 2015 at 8:13 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> On Mon, Apr 6, 2015 at 3:49 PM, Bjorn Helgaas <bhelgaas@google.com> wro=
te:
>>>>
>>>> For "[PATCH 1/3] PCI: Introduce pci_bus_addr_t", I'm waiting for an up=
dated
>>>> version with Kconfig tweaks so we don't break other arches.
>>>
>>> I was thinking that you will update it manually.
>>
>> I asked you for an updated version, incorporating the documentation
>> updates, to make sure I got everything you intended.  But I did go
>> ahead and do it manually for you.
>
> Good.
>
> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=3Df=
or-linus&id=F70899ff889a38f9697d3c153aaacaed25f501c3
>
> Please consider to split that into two patches.
> First one include changes in : include/linux/types.h and
> Documentation/DMA-API-HOWTO.txt.
> and you should be author for that.

If you want something different, send patches.  I don't have time to
try to figure out your intent and do the work for you.  That's why I
asked you for an updated series in the first place.

Bjorn
