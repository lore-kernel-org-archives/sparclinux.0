From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 21 Dec 2016 18:10:37 +0000
Subject: Re: [PATCH v2] sparc64: shut down to OBP correctly
Message-Id: <20161221181037.GA3311@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1482340634-65842-1-git-send-email-larry.bassel@oracle.com>
In-Reply-To: <1482340634-65842-1-git-send-email-larry.bassel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Larry.

Little nitpick...

>  	args[2] = 0;
>  	p1275_cmd_direct(args);
> -	goto again; /* PROM is out to get me -DaveM */
> +	while (1);

If you write this like:

	for (;;)
		/* forever */;

It is much more obvious that this is supposed to loop forever.
As it is now it more looks like an oversight.

	Sam
