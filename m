From: David Miller <davem@davemloft.net>
Date: Sat, 28 Mar 2015 18:16:21 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <20150328.111621.1041514784349808716.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <551495EE.20201@oracle.com>
	<CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com>
	<CAE9FiQWwU4gsq4y0+BTMtisBGQDxF1m_pxAT62PmP-Ct+O1c5A@mail.gmail.com>
In-Reply-To: <CAE9FiQWwU4gsq4y0+BTMtisBGQDxF1m_pxAT62PmP-Ct+O1c5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yinghai@kernel.org
Cc: david.ahern@oracle.com, bhelgaas@google.com, linux-pci@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 27 Mar 2015 16:57:23 -0700

> On Fri, Mar 27, 2015 at 2:01 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Thu, Mar 26, 2015 at 4:27 PM, David Ahern <david.ahern@oracle.com> wrote:
> 
>> Also please make sure your config have
>>
>> CONFIG_PCI_DEBUG=y
>>
>> and capture serial console with "debug ignore_loglevel", so we check if
>> pci 0000:00:01.0 really have resource assigned.
> 
> Please check attached patch and send out boot log with above config.

PCI addresses being 64-bit or not is an attribute of the PCI
controller and the geography of the bridges behind it, not the
cpu architecture.
