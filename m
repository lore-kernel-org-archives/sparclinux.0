From: David Miller <davem@davemloft.net>
Date: Wed, 21 Dec 2011 20:31:52 +0000
Subject: Re: [PATCH 1/2] sparc: Make SA_NOMASK a synonym of SA_NODEFER
Message-Id: <20111221.153152.331142885585888750.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1324493221-4435-1-git-send-email-matt@console-pimps.org>
	<1324493221-4435-2-git-send-email-matt@console-pimps.org>
In-Reply-To: <1324493221-4435-2-git-send-email-matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: matt@console-pimps.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, oleg@redhat.com, matt.fleming@intel.com, sparclinux@vger.kernel.org

From: Matt Fleming <matt@console-pimps.org>
Date: Wed, 21 Dec 2011 18:47:00 +0000

> From: Matt Fleming <matt.fleming@intel.com>
> 
> Unlike other architectures, sparc currently has no SA_NODEFER
> definition but only the older SA_NOMASK. Since SA_NOMASK is the
> historical name for SA_NODEFER, add SA_NODEFER and copy what other
> architectures do by making SA_NOMASK a synonym for SA_NODEFER.
> 
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Matt Fleming <matt.fleming@intel.com>

Acked-by: David S. Miller <davem@davemloft.net>
