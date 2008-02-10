From: David Rientjes <rientjes@google.com>
Date: Sun, 10 Feb 2008 19:19:41 +0000
Subject: Re: sparc compile error
Message-Id: <alpine.DEB.1.00.0802101117510.5043@chino.kir.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080207231230.GE7198@cs181133002.pp.htv.fi> <alpine.DEB.1.00.0802071538440.15050@chino.kir.corp.google.com> <20080210153355.GA6737@palantir8>
In-Reply-To: <20080210153355.GA6737@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Habets <errandir_news@mph.eclipse.co.uk>
Cc: Adrian Bunk <bunk@kernel.org>, wli@holomorphy.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Sun, 10 Feb 2008, Martin Habets wrote:

> This still gives build errors with CGROUP_MEM_CONT off.
> Some ifdef-ing will fix that.
> 

Please try Linus' latest git that includes 60c12b12 (from yesterday) that 
fixes this issue.

		David
