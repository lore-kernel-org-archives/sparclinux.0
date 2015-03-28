From: David Ahern <david.ahern@oracle.com>
Date: Sat, 28 Mar 2015 00:36:18 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <5515F782.7060301@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5514391F.2030300@oracle.com>	<CAE9FiQXw3QUCNNZj2SVhn-AYWWnggT=7JXPkGNpYFzq-qAB1aQ@mail.gmail.com>	<551495EE.20201@oracle.com>	<CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com> <CAE9FiQWwU4gsq4y0+BTMtisBGQDxF1m_pxAT62PmP-Ct+O1c5A@mail.gmail.com> <5515F6B8.8020606@oracle.com>
In-Reply-To: <5515F6B8.8020606@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 3/27/15 6:32 PM, David Ahern wrote:
> On 3/27/15 5:57 PM, Yinghai Lu wrote:
>> On Fri, Mar 27, 2015 at 2:01 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> On Thu, Mar 26, 2015 at 4:27 PM, David Ahern <david.ahern@oracle.com>
>>> wrote:
>>
>>> Also please make sure your config have
>>>
>>> CONFIG_PCI_DEBUG=y
>>>
>>> and capture serial console with "debug ignore_loglevel", so we check if
>>> pci 0000:00:01.0 really have resource assigned.
>>
>> Please check attached patch and send out boot log with above config.
>
> patched applied. PCI_DEBUG enabled. options added. log attached. This is
> with d63e2e1f3df reverted still.
>

oops lied about that last one; I forgot to revert the patch this round. 
That the system booted with it applied is progress.

David
