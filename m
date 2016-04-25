From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 25 Apr 2016 20:18:19 +0000
Subject: Re: [PATCH V3 1/3] Use proper size for task_struct->flags
Message-Id: <20160425201819.GA18464@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1461608888-5063-2-git-send-email-dave.kleikamp@oracle.com>
In-Reply-To: <1461608888-5063-2-git-send-email-dave.kleikamp@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Apr 25, 2016 at 01:28:06PM -0500, Dave Kleikamp wrote:
> task_struct->flags was once defined as a long, but is currently an int.
> 
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
