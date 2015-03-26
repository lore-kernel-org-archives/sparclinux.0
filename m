From: David Ahern <david.ahern@oracle.com>
Date: Thu, 26 Mar 2015 16:51:43 +0000
Subject: d63e2e1f3df breaks sparc/T5-8
Message-Id: <5514391F.2030300@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yinghai@kernel.org, sparclinux@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>

Hi:

Boot of an 8-socket T5 sparc system fails on top of tree. git bisect 
points to this commit:

commit 	904bf6bd150bdafb42ddbb3257ea8
Author: Yinghai Lu <yinghai@kernel.org>
Date:   Thu Jan 15 16:21:51 2015 -0600

sparc/PCI: Clip bridge windows to fit in upstream windows

Every PCI-PCI bridge window should fit inside an upstream bridge window 
because orphaned address space is unreachable from the primary side of 
the upstream bridge.  If we inherit invalid bridge windows that overlap 
an upstream window from firmware, clip them to fit and update the bridge 
accordingly.


Sure enough if I revert it on top of tree the system boots fine.

David
