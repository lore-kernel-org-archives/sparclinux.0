From: Yinghai Lu <yinghai@kernel.org>
Date: Thu, 26 Mar 2015 20:43:43 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <CAE9FiQXw3QUCNNZj2SVhn-AYWWnggT=7JXPkGNpYFzq-qAB1aQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5514391F.2030300@oracle.com>
In-Reply-To: <5514391F.2030300@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Ahern <david.ahern@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

[+bjorn, pci list]

On Thu, Mar 26, 2015 at 9:51 AM, David Ahern <david.ahern@oracle.com> wrote:
> Hi:
>
> Boot of an 8-socket T5 sparc system fails on top of tree. git bisect points
> to this commit:
>
> commit  904bf6bd150bdafb42ddbb3257ea8
> Author: Yinghai Lu <yinghai@kernel.org>
> Date:   Thu Jan 15 16:21:51 2015 -0600
>
> sparc/PCI: Clip bridge windows to fit in upstream windows
>
> Every PCI-PCI bridge window should fit inside an upstream bridge window
> because orphaned address space is unreachable from the primary side of the
> upstream bridge.  If we inherit invalid bridge windows that overlap an
> upstream window from firmware, clip them to fit and update the bridge
> accordingly.
>
>
> Sure enough if I revert it on top of tree the system boots fine.

Can you send out boot log with "debug ignore_loglevel"?

Thanks

Yinghai
