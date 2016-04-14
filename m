From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 14 Apr 2016 13:30:45 +0000
Subject: Re: Enable module aliases for vio on sparc/sparc64
Message-Id: <20160414133045.GA5847@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <570B52AE.8080603@physik.fu-berlin.de>
In-Reply-To: <570B52AE.8080603@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Adrian.

> >> Date: Thu, 14 Apr 2016 01:16:14 +0200
> >> Subject: [PATCH 1/2] sparc: Implement and wire up modalias_show for vio.
> > 
> > It would be nice if you could add here the effect this patch has - that
> > it fixes the debian installer.
> 
> Hmm, I'm not sure whether this belongs here. I thought it was obvious
> what these two changes are for due to the canonical function names.
Just a suggestion - skip it as you prefer.

> >> +static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
> >> +                             char *buf)
> > Please use tabs and the appropriate number of spaces to indent.
> 
> I used the same indentation that is used for modalias_show in
> arch/powerpc/kernel/vio.c but I wasn't sure what the proper
> indentation would be in this case.
> 
> Can you suggest the right indentation?
You shall uses tabs and the necessary number of spaces so the
arguments are aligned with the first argument.
So the alignment is fine - just replace preceeding spaces with tabs.

Like this:
static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
			     char *buf)

Three leading tabs, then 5 spaces.

> > 
> > At sparclinux we usually submit one patch per mail.
> > And patches which are specific for either sparc32 or sparc64 are prefixed so.
> > 
> > Like this
> > [PATCH 1/2] sparc64: ...
> > [PATCH 2/2] sparc64: ...
> 
> Yeah, I know. I can re-send them with git send-email if that's desired,
> I just wanted to avoid cluttering the discussion too much.
It is my understanding that this is simpler for davem when applying patches.
But maybe patchwork makes things easier with respect to attached patches.
Anyway - if you follow the normal pattern then everything should just works.

Most important, document what was changed from v1 to v2 -
so when davem and other looks at this they know what was changed.

	Sam
