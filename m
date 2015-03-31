From: David Ahern <david.ahern@oracle.com>
Date: Tue, 31 Mar 2015 04:10:26 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <551A1E32.1010309@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5514391F.2030300@oracle.com>	<CAE9FiQXw3QUCNNZj2SVhn-AYWWnggT=7JXPkGNpYFzq-qAB1aQ@mail.gmail.com>	<551495EE.20201@oracle.com>	<CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com>	<CAE9FiQWwU4gsq4y0+BTMtisBGQDxF1m_pxAT62PmP-Ct+O1c5A@mail.gmail.com>	<5515F6B8.8020606@oracle.com>	<5515F782.7060301@oracle.com>	<CAE9FiQXpNKrX9BuC5-sgb8XEdFPN1a-wBRR2XqY5Mh1cnhXSPQ@mail.gmail.com>	<551623C1.2040300@oracle.com>	<CAE9FiQUNLaNYAk6DoTDCAfbS=B1uks_=381KJDUk46+yg5cVwg@mail.gmail.com>	<5516BF4B.9030901@oracle.com>	<CAE9FiQV_BOKQu8+mCqQRx_RJYucwuGAfJog7qoUW0J_i=9u=Tg@mail.gmail.com>	<55181065.8090807@oracle.com>	<CAE9FiQXu8qvCo9Dx6vUBXEO029n8K=c=CGtsfvWMGYdVgqtgOw@mail.gmail.com>	<5519D40D.20903@oracle.com> <CAE9FiQUVSRkKNRzh99JA7V8dqsY78z_GtnMnwTrpSFXkJV9CKA@mail.gmail.com>
In-Reply-To: <CAE9FiQUVSRkKNRzh99JA7V8dqsY78z_GtnMnwTrpSFXkJV9CKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>, Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 3/30/15 7:06 PM, Yinghai Lu wrote:
> ok, that is really non-pref mmio 64bit.
> We can workaround the problem by honoring firmware setting, according
> to https://www.pcisig.com/specifications/pciexpress/base2/PCIe_Base_r2.1_Errata_08Jun10.pdf
> page 13
>
> Please check attached updated patches that should fix the regression
> and kill those "no compatible window" warnings.

To make sure I am on the same page: these are a new round of patches? 
clear out the old, apply these?

David

