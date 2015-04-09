From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 09 Apr 2015 04:26:50 +0000
Subject: Re: [PATCH 3/3] PCI: Set pref for mem64 resource of pcie device
Message-Id: <CAErSpo5VwuLjZtQFcJqfpkC=j5TJmLD0oZPQ=6oJpSOthB+BFA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
 <1427857069-6789-4-git-send-email-yinghai@kernel.org> <20150406220638.GH10892@google.com>
 <20150406.203533.1356187749826485194.davem@davemloft.net> <CAErSpo7zvqft2frrwCd5AKMSO1LB7=7Ys9stKsj7OGzkQv4K1Q@mail.gmail.com>
 <20150408154759.GN10892@google.com> <1428527527.18187.28.camel@kernel.crashing.org>
 <CAE9FiQXQN-VqN3ynLEhHh5WUYE+8tLR8ubKKMeHZ3h=BQ0rA9A@mail.gmail.com> <1428549459.18187.56.camel@kernel.crashing.org>
In-Reply-To: <1428549459.18187.56.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Yinghai Lu <yinghai@kernel.org>, David Miller <davem@davemloft.net>, David Ahern <david.ahern@oracle.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

On Wed, Apr 8, 2015 at 10:17 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2015-04-08 at 17:06 -0700, Yinghai Lu wrote:
>> On Wed, Apr 8, 2015 at 2:12 PM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>>
>> > Thanks Bjorn. We can fix Yinghai patch for 4.2, it would be indeed handy
>> > even for us to be able to support putting 64-bit NP BARs in prefetch
>> > windows (For some SR-IOV adapters for example) too, but we need to do it
>> > right.
>>
>> Please check if you are ok with attached.
>
> I'll let Bjorn be the final judge here but I am not fan of the way you
> set/clear/set/clear the IORESOURCE_PREFETCH bit with
> pci_set_pref_under_pref(). It's error prone and confusing, the code is
> already barely readable as it is ...
>
> I would rather you replace those various masks compares with a helper
> that does something like pci_resource_compatible(parent_res, child_res),
> which has the logic to test. That or a helper that does something like
> pci_calc_compatible_res_flags() which returns a "flags" that has
> PREFETCH set, which you use in place of res->flags in the various
> allocation path.

I'm not planning to review this until after the merge window opens,
but I took a quick glance, and I agree with Ben.  I don't want to add
a new IORESOURCE_ flag.  I think a pci_resource_compatible() helper is
a great idea.

I am absolutely not in favor of "minimally intrusive" as a goal.
"Minimally intrusive" sounds good but it is often used to justify
clever hacks which end up being an anti-maintainer strategy in the
long term.  "Maximum readability" is what I'm looking for.

Bjorn
