From: David Miller <davem@davemloft.net>
Date: Thu, 06 Oct 2016 05:42:49 +0000
Subject: Re: [PATCH] sparc: migrate exception table users off module.h and onto extable.h
Message-Id: <20161006.014249.980841558877493281.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20160919213629.5125-1-paul.gortmaker@windriver.com>
In-Reply-To: <20160919213629.5125-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: paul.gortmaker@windriver.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 19 Sep 2016 17:36:29 -0400

> These files were only including module.h for exception table
> related functions.  We've now separated that content out into its
> own file "extable.h" so now move over to that and avoid all the
> extra header content in module.h that we don't really need to compile
> these files.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied.
