From: David Miller <davem@redhat.com>
Date: Wed, 03 Jun 2020 01:46:08 +0000
Subject: Re: [PATCH 0/3] sparc32 SRMMU fixes for SMP
Message-Id: <20200602.184608.797176631158669285.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200526173302.377-1-will@kernel.org>
In-Reply-To: <20200526173302.377-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: will@kernel.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, peterz@infradead.org, linux@roeck-us.net, rppt@kernel.org, kernel-team@android.com

From: Will Deacon <will@kernel.org>
Date: Tue, 26 May 2020 18:32:59 +0100

> Hi folks,
> 
> Enabling SMP for sparc32 uncovered some issues in the SRMMU page-table
> allocation code. One of these was introduced by me, but the other two
> seem to have been there a while and are probably just exposed more
> easily by my recent changes.
> 
> Tested on QEMU. I'm assuming these will go via David's tree.

Series applied, thanks Will.
