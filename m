From: David Miller <davem@davemloft.net>
Date: Thu, 20 Aug 2015 18:40:42 +0000
Subject: Re: [PATCH] PCI/ASPM: Fix a NULL pointer crash on sparc64
Message-Id: <20150820.114042.1327127338658980319.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150820054800.GB10267@google.com>
	<20150820.104728.699050706854625548.davem@davemloft.net>
	<CAErSpo5SApFYWOs8Q2ZH2vpnEW6jY0XWAgeiyhMk4aCNtON46w@mail.gmail.com>
In-Reply-To: <CAErSpo5SApFYWOs8Q2ZH2vpnEW6jY0XWAgeiyhMk4aCNtON46w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bhelgaas@google.com
Cc: wangyijing@huawei.com, linux-pci@vger.kernel.org, mroos@linux.ee, sparclinux@vger.kernel.org, eric.snowberg@oracle.com, benh@kernel.crashing.org

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 20 Aug 2015 11:23:43 -0700

> On Thu, Aug 20, 2015 at 10:47 AM, David Miller <davem@davemloft.net> wrote:
>> From: Bjorn Helgaas <bhelgaas@google.com>
>> Date: Thu, 20 Aug 2015 00:48:00 -0500
>>
>>> [+cc Dave, Eric, Ben, sparclinux]
>>
>> I think the comment is terrible.
> 
> I'll update the comment if you suggest some text.  Do you object
> mainly to the mention of the specific systems?

"PCI root complex can not be assumed to be instantiated in the PCI bus
 hierarchy."
 
