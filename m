From: David Miller <davem@davemloft.net>
Date: Sun, 11 Jan 2009 08:31:03 +0000
Subject: cpumask change causes sparc build bustage
Message-Id: <20090111.003103.39502700.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, travis@sgi.com, mingo@elte.hu


drivers/pci/probe.c: In function 'pci_bus_show_cpuaffinity':
drivers/pci/probe.c:56: error: implicit declaration of function 'cpumask_of_pcibus'
drivers/pci/probe.c:56: warning: assignment makes pointer from integer without a cast

Almost certainly caused by:

commit 588235bb53f2c215f0d4b08fd30b461fedc3338e
Author: Mike Travis <travis@sgi.com>
Date:   Sun Jan 4 05:18:02 2009 -0800

    cpumask: update pci_bus_show_cpuaffinity to use new cpumask API
    
    Impact: use new cpumask API to reduce stack usage
    
    Replace the local cpumask_t variable with a pointer to the
    const cpumask that needs to be printed.
    
    Signed-off-by: Mike Travis <travis@sgi.com>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

I'm surprised linux-next builds didn't catch this.
