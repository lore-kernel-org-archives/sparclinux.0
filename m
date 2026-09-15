Received: from mail-lr2-f36.google.com (mail-lr2-f36.google.com [74.125.230.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DED4C8C67
	for <sparclinux@vger.kernel.org>; Tue, 15 Sep 2026 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499819; cv=none; b=FcgyTkwRDZY/8pdDywXtBHqHuR3j+Qm2Tm4BGvCTAbTJo9sKWY7DqSK6+5+LwZBPk/yKgYevyxca6iJX2gYSJJB/pAsR+ZdIg9iiaJYRtm/TmSqy1g+oMuns+nBckskgoO2vGG0FNAeNvwOGyBZdxg5DknESCAmW5P0zcfkVTgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499819; c=relaxed/simple;
	bh=AGk4y8oFpNibhByHKIxcRS7KnQx6z20Q8VC6dFl1tNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISkAnOxpC6MvJPPVRcdv0SXUZYdNoRb2I5CNe4PuuB/tfZMfFwe+G+quPOZiYWOAHs+DacxCQG02vRRRlX3wO4AJG2RQoIo7fOBux2QTPEiazZ2YuZasPhHoIDQoblO01x3MKZpNzhYfP4vCOKAKMwScFzkXf7LaHMjgwNhzImM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Bqf8TOsK; arc=none smtp.client-ip=74.125.230.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Bqf8TOsK"
Received: by mail-lr2-f36.google.com with SMTP id 38308e7fff4ca-3a2ff174422so1321301fa.3
        for <sparclinux@vger.kernel.org>; Tue, 15 Sep 2026 12:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789499814; x=1790104614; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=Bqf8TOsK/wYmsYC6x4JOeXRJlL30DRhibX/Q5FgIvFhIqpYAaysubtmaRadSxfgchH
         PXoDMmA42tB5SwMJ6fWoqPt2Y9pJB3H5CJivsPezvNKZskD7gGKXrW5kmzxUgqqiK/X2
         2NGgegio5stWXaaE1X6VS/ul/6uNxmuFw07uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789499814; x=1790104614;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=g5QfIzNOgeTcvZgm0zjLkkios5JPuzqxiMRO+4AAEl1BzgNbKm4dQZQZaR5D7ZKJzm
         9PK6Y/Fcprv5Lf+nI8e1LQFI/vPuQXKQhEE7sWE4NnjS8HuppqudVMK1KzNZ0YOT2zdF
         RreBRFU5y4t9/saD5SfkYS2WcjoTXEZs6FjGgC6cVUYgfIFwg4N/y+Hls27SLE1dnbvS
         j2eXwkl/hwaS87If287qhEaBeUkOwoJbxNU/P7en+rrQXA24LJ1Q5OQ98VaegDoFVhYO
         j2zXOF9TQut3uKXsAX5LaCz3voAVIg+4WrC1O9r5lMuM01AqV/3qYRBsv8hnZsU5HITw
         AWJQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8m4l4s+gwZY0Sn/jRXdZgkOjmK+MnwiYtglsdo7oOFf83JQSUgsx1qlTR9MWBujJs6FBnxtGgKffs@vger.kernel.org
X-Gm-Message-State: AFuF++k9Zf0vuNSOW5roYE2bYgqrT4WIfS6wZpbvBafLRxZR1DxDfTDd
	zS0aCKXAVtOTwlJXKIviPCuIP76t6Fm1D5pSC8FS/ThF8fpWGG9d3s/BjY5SKuqjNb+tNQjrVE0
	vx6Syf8tnCIGv
X-Gm-Gg: AYBFou1gRoWRHi8RM9GeZKyDGMNFblAUndjIZ3IqhMYUb54Osr/fpfrdhmddcfBAFYA
	A13pRljytr8t5naHXJn+s4CL2GI1M9DJzFD0LmrnHmJpdXNfNDlhszoinOCfwa43idbLsDQhIE0
	FjA37oH6qxTozx3SQg6K6nuFqtFiXLeiBde/GSAQbwgi1QR0VuZkBsQNjNIp12XpKHSi5Mw815d
	/+I7q6vnc+Gdvd4WzKuuNPxGD1but8QPSmM4p5K19jn3SkLrnXFgi17idqYCA9EJq/TqUKWyrps
	EEayDDM3IF6izeVivcGUAItVB0+ORRCt+JO9AgjFMtLs0NHJfQMRAIwM1ddzxotMcQ3Do+31mVa
	IjEntr5s2UZsmpGzZg1A0I/pzhBqLlmjz2U6GMsS/Hz9AKY5JGopX/SmX7l6VjCqV40zt8bXRvW
	rlHMbhtcSTmjwXm2txDYXV2ssZbm5S60d/PjhM8+Zx/R+lz7+O7a/yOzgwnE12s+wC7NjFJiJxW
	wxzTY4c1pPcSFv0wGmVBBEbnjmiW7BPOG3Cr4scUeWc63SWHx0or1xq+P5k
X-Received: by 2002:a05:6512:130c:b0:5b4:3ddd:8996 with SMTP id 2adb3069b0e04-5b8ae69843cmr4788599e87.15.1789499814534;
        Tue, 15 Sep 2026 12:16:54 -0700 (PDT)
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com. [74.125.229.204])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b57c36d7sm170461e87.23.2026.09.15.12.16.54
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 12:16:54 -0700 (PDT)
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f15b79so106420e87.1
        for <sparclinux@vger.kernel.org>; Tue, 15 Sep 2026 12:16:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxqg6FEt/6DjeNGfbx5Mz5XbmPpsYfHvzwHvK4TTw3KWNvFGE36m1kvVXmYJsW2f7FxxU9AX4HQCN/m@vger.kernel.org
X-Received: by 2002:a17:906:7309:b0:c25:47a4:fedc with SMTP id
 a640c23a62f3a-c29b839a057mr1176039766b.2.1789499355710; Tue, 15 Sep 2026
 12:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
In-Reply-To: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 12:08:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
X-Gm-Features: AcwNN1VCm0LMG7z3Jned014oJh6WBcf4uOx0OBk98_hrtHKbrhcQiMMJ_A-fmB0
Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 10:52, Jann Horn <jannh@google.com> wrote:
>
> Is this mainly about stuff like "we installed a file descriptor and
> then the following put_user() failed"? Because if so, I think a nicer
> fix would be to have a policy of "if userspace provides unwritable
> memory to a syscall, just keep going and pretend the access worked",
> and maybe have a sysctl that kills the process when this happens to
> emphasize that userspace should not be doing this.

We've done that before, where we just ignore put_user() errors and the
user gets whatever the user gets.

It is maybe not optimal, but it's fine. You can find quite a lot of
unchecked put_user() calls with a pattern like

        git grep '^[[:space:]]*put_user(.*);'

and some of them are in core code - see the two in kernel/fork.c, for example.

One of them says "if userspace has not set up a proper pointer then
tough luck". The other one doesn't even bother with a comment.

The scheduler has two cases too, although one of them is admittedly
for another error case.

So yes, saying "if you pass bogus arguments, you get what you get" is
a valid model. It's perhaps not the *preferred* model, but it's not
wrong.

It *would* be wrong to take code that already has error handling and
remove the error handling, though.

                  Linus
