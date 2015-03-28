From: Yinghai Lu <yinghai@kernel.org>
Date: Sat, 28 Mar 2015 03:27:26 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <CAE9FiQXOWZLwfSbk-1y=8hCUSjGxWZSyPMxPMtF3_he5uT575g@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5514391F.2030300@oracle.com>
	<CAE9FiQXw3QUCNNZj2SVhn-AYWWnggT=7JXPkGNpYFzq-qAB1aQ@mail.gmail.com>
	<551495EE.20201@oracle.com>
	<CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com>
	<CAE9FiQWwU4gsq4y0+BTMtisBGQDxF1m_pxAT62PmP-Ct+O1c5A@mail.gmail.com>
	<5515F6B8.8020606@oracle.com>
	<5515F782.7060301@oracle.com>
	<CAE9FiQXpNKrX9BuC5-sgb8XEdFPN1a-wBRR2XqY5Mh1cnhXSPQ@mail.gmail.com>
	<55161E5E.4040609@oracle.com>
In-Reply-To: <55161E5E.4040609@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Ahern <david.ahern@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Fri, Mar 27, 2015 at 8:22 PM, David Ahern <david.ahern@oracle.com> wrote:
> On 3/27/15 9:19 PM, Yinghai Lu wrote:
>>
>> Good. But we still have annoying warning about "no compatible window".
>>
>> Please try attached patch that support 64bit pci mem space for sparc.
>
>
> in place of or on top of the previous patch?

on top of the previous patch.

Thanks

Yinghai
