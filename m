From: David Miller <davem@davemloft.net>
Date: Fri, 21 Jul 2017 02:51:47 +0000
Subject: Re: [PATCH v1 3/4] sparc64: context domains
Message-Id: <20170721.035147.577912019966035683.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1500601861-203232-4-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1500601861-203232-4-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 20 Jul 2017 21:51:00 -0400

> +void cd_cpu_offline(int cpu);
> +void cd_cpu_offline(int cpu);

Same function declared twice?
