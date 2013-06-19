From: David Miller <davem@davemloft.net>
Date: Wed, 19 Jun 2013 09:14:50 +0000
Subject: Re: [PATCH V2 1/15] sparc,leon: Convert to use devm_ioremap_resource
Message-Id: <20130619.021450.1126981647735749233.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1370864113-17895-2-git-send-email-tushar.behera@linaro.org>
	<1371460064-19549-1-git-send-email-tushar.behera@linaro.org>
In-Reply-To: <1371460064-19549-1-git-send-email-tushar.behera@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tushar.behera@linaro.org
Cc: linux-kernel@vger.kernel.org, thierry.reding@gmail.com, patches@linaro.org, sachin.kamat@linaro.org, sparclinux@vger.kernel.org

From: Tushar Behera <tushar.behera@linaro.org>
Date: Mon, 17 Jun 2013 14:37:44 +0530

> Commit 75096579c3ac ("lib: devres: Introduce devm_ioremap_resource()")
> introduced devm_ioremap_resource() and deprecated the use of
> devm_request_and_ioremap().
> 
> While at it, also remove the error message as devm_ioremap_resource()
> also prints similar error message.
> 
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>

Applied.
