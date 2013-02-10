From: David Miller <davem@davemloft.net>
Date: Sun, 10 Feb 2013 23:08:18 +0000
Subject: Re: [PATCH 04/16] sparc idle: rename pm_idle to sparc_idle
Message-Id: <20130210.180818.1981510882315670043.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1360475903-30007-1-git-send-email-lenb@kernel.org>
	<2b219d07e0f287c2c713f5465fc8646158fa986e.1360475150.git.len.brown@intel.com>
	<3a242f58a5f40c60568cb1e3b13f119432203f48.1360475150.git.len.brown@intel.com>
In-Reply-To: <3a242f58a5f40c60568cb1e3b13f119432203f48.1360475150.git.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, len.brown@intel.com, sparclinux@vger.kernel.org

From: Len Brown <lenb@kernel.org>
Date: Sun, 10 Feb 2013 00:58:11 -0500

> From: Len Brown <len.brown@intel.com>
> 
> (pm_idle)() is being removed from linux/pm.h
> because Linux does not have such a cross-architecture concept.
> 
> sparc uses an idle function pointer in its architecture
> specific code.  So we re-name sparc use of pm_idle to sparc_idle.
> 
> Maybe some day, SPARC will cut over to cpuidle...
> 
> Signed-off-by: Len Brown <len.brown@intel.com>

Acked-by: David S. Miller <davem@davemloft.net>
