From: David Miller <davem@davemloft.net>
Date: Mon, 08 Oct 2018 05:57:45 +0000
Subject: Re: [PATCH] oradax: remove redundant null check before kfree
Message-Id: <20181007.225745.1952895704234282902.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20180907103500.17453-1-colin.king@canonical.com>
In-Reply-To: <20180907103500.17453-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: colin.king@canonical.com
Cc: rob.gardner@oracle.com, jonathan.helman@oracle.com, sparclinux@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Fri,  7 Sep 2018 11:35:00 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> A null check before a kfree is redundant, so remove it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
