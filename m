From: David Miller <davem@davemloft.net>
Date: Thu, 25 Sep 2014 15:53:21 +0000
Subject: Re: [PATCH V3] sparc64: sparse irq
Message-Id: <20140925.115321.1866396647897673920.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410982288-10549-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410982288-10549-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Wed, 17 Sep 2014 15:31:28 -0400

> I've tested with SPARSE_IRQ on T5-8, M7-4 and T4-X and Jalap?no.

I'm currently reviewing this, and I have to ask if any of your Niagara
test scenerios had a hypervisor with HV_GRP_INTR major < 3?

I have a sense that the legacy hypervisor case wasn't covered, and
it seems that this patch will emit an ugly log message when that
situation is triggered which probably isn't appropriate as the
event isn't an error.  It's just an older hypervisor that lacks
cookie only VIRQ support.
