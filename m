From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 Feb 2011 22:28:43 +0000
Subject: Re: [PATCH] sparc64: fix unused-but-set-variable warnings
Message-Id: <20110226222843.GA24077@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110226085151.GA23117@merkur.ravnborg.org>
In-Reply-To: <20110226085151.GA23117@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David - please do not apply this yet.
I need to go through it to convince myself that it is OK to ignore
the return resut in the cases where I blindly deleted it for now.

I will repost when I have done so.

Dennis - I would still like to know if this fixes all
sparc warnings so you no longer need to drop -Werror.

	Sam
