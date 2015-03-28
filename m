From: David Ahern <david.ahern@oracle.com>
Date: Sat, 28 Mar 2015 03:22:06 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <55161E5E.4040609@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5514391F.2030300@oracle.com>	<CAE9FiQXw3QUCNNZj2SVhn-AYWWnggT=7JXPkGNpYFzq-qAB1aQ@mail.gmail.com>	<551495EE.20201@oracle.com>	<CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com>	<CAE9FiQWwU4gsq4y0+BTMtisBGQDxF1m_pxAT62PmP-Ct+O1c5A@mail.gmail.com>	<5515F6B8.8020606@oracle.com>	<5515F782.7060301@oracle.com> <CAE9FiQXpNKrX9BuC5-sgb8XEdFPN1a-wBRR2XqY5Mh1cnhXSPQ@mail.gmail.com>
In-Reply-To: <CAE9FiQXpNKrX9BuC5-sgb8XEdFPN1a-wBRR2XqY5Mh1cnhXSPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 3/27/15 9:19 PM, Yinghai Lu wrote:
> Good. But we still have annoying warning about "no compatible window".
>
> Please try attached patch that support 64bit pci mem space for sparc.

in place of or on top of the previous patch?

>
> BTW, looks like you still do not have   CONFIG_PCI_DEBUG=y in your .config.
> otherwise we should more verbose print out.

# zcat /proc/config.gz  | grep PCI_DEBUG
CONFIG_PCI_DEBUG=y

> Or did you have DYNAMIC_DEBUG enabled ?

# zcat /proc/config.gz  | grep DYNAMIC
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_SND_DYNAMIC_MINORS=y
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_DYNAMIC_DEBUG=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE=y

> If it is that case, can you remove that?

will do; wasn't aware of it before now. Let me know about the patch ordering
