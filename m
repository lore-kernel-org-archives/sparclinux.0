From: David Miller <davem@davemloft.net>
Date: Thu, 14 May 2015 03:55:43 +0000
Subject: Re: [PATCH v2] sparc64: pci slots information is not populated in sysfs
Message-Id: <20150513.235543.1420996136261895921.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1430254277-208174-1-git-send-email-eric.snowberg@oracle.com>
In-Reply-To: <1430254277-208174-1-git-send-email-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eric Snowberg <eric.snowberg@oracle.com>
Date: Tue, 28 Apr 2015 16:51:17 -0400

> Add PCI slot numbers within sysfs for sun4v hardware. Larger
> sun4v systems contain nested PCI bridges and slots further
> down on these bridges were not being populated within sysfs.
> Also add ACPI style PCI slot numbers within sysfs for sun4v
> hardware since the OF 'slot-names' information is not available
> on all sun4v platforms.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> 
> ---
> Changes in v2:
>   - Addresses Julian Calaby's comments: moved hypervisor test
>       outside the while loop and updated the typo in the
>       commit comment.

This property definitely exists in sun4u systems, "Ultra 45" and "Sun
Fire V245" at a minimum.

You can see this clearly by merely perusing the prtconf dumps in my
'prtconfs' GIT repository.

So it makes no sense at all the limit this code to sun4v systems.
