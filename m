Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3D3EB80D
	for <sparclinux@vger.kernel.org>; Thu, 18 Jun 2026 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781778756; cv=none; b=tXYbK8YugYGGtLf9bR3aTarmaSlSl+LGatsSWg9JYe+Du3pp27aw9mqa4fxZX0Y8kky2raKF9/4S7B3MAeq9nrV0SaswUZpQVyzsx4PrH6N9XzVwG4L/rqUOYePdekTrX3MvYVGM7FUKc22rYrCN7t/q4WD8+R4tQQRRX7Q+Rcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781778756; c=relaxed/simple;
	bh=vwsitVN7ozdKpgBSF4h9WVQoKxMhPysr7paPs2RYr+E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQ6jJ9m1weh3wjjM8LNgdR+pm/9c659Mk4tM7zLo9N25kXh/gy0kKNnchxDoFrXhkGOMLjxbTtuW4JtvmMj/EM+TrRkoaVxOMJAGKn5HfSCuhm7c2Qeaf9V6e1fnChIOIsmHONpo+JyqByqU8dZEXhXoeAZ90J4AZiS7PLVtUlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+DDYPXd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+DDYPXd"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso7637795e9.3
        for <sparclinux@vger.kernel.org>; Thu, 18 Jun 2026 03:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781778752; x=1782383552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inqN7YwVEl5wZ+Codcae/bocVL29CD4f5KlLdUvEZRU=;
        b=h+DDYPXdELq4WUnUUb6ifz6APZOpo8FXcIml8fZ9HUcx9JY3BXSqKNSCN4kfnmGMPG
         S2Z+sPI3OukOFOqXO/E7Jb00lBG3BJmOJJnnRo/ML1KstJ4Msnh+LN6l1CdyG4OGxlAR
         kMbog3ALjm5/uD8vjQhcrxEkuG3RmiUcckafjcjG+K76RbXpeh0cHaJ/6xXUHFs2tWIg
         +U0o7JAOvUTKMTEmmygbAOtJ5uHgMeiyjVvwUdphLBefn/ZT/c/hKtRsoslbP/VkG5E7
         KuQ6v9yEz3+o+9RpqiOlIbTq3aCG7NQ/u49WNeTVIc7ZQBfkk8KufC/V56nIB00i2Inc
         IqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781778752; x=1782383552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=inqN7YwVEl5wZ+Codcae/bocVL29CD4f5KlLdUvEZRU=;
        b=JK/8pdYSmnViioeOoC0tvyWDKOP+GIOf+HjQNjSZKK4I4LeQFDPqz1lYwp/edzSKdv
         rKBW0zTu4veG5rAwmKA/9clXfUXz5nU1ZLzjcnEJnJfDwsr+DkkzLgjO+1WD1jvDP+mx
         9WCCtTqJODF7zBZX0LItzdy3dQhBVHO5NIIngBpmwP4WfgnwaHBAl4B6+4Y5imkoEpoz
         ta29dJNwaoFvgyQ1Ew/RqerJvOuFLlYjnSiz8CUGqudrRiEqzgZv4BUOb8wRIdDgRpqx
         JQrXSrdhvGJ6hjVKxDjsdxHDi05Yl+Vuh7A2zPKuymgHRJqhdyAqxXlkf6JOZ9uBY1k6
         wHiw==
X-Forwarded-Encrypted: i=1; AFNElJ8iSeX9wUhyGPi6cCvvBTHfLowEPhqzPxJC30bQaoV/Xt7BukBO4UfzDf1lRm9CO8ZHCif/WYtBVbXK@vger.kernel.org
X-Gm-Message-State: AOJu0YwRFt4x7AjzzgYJg72x1dUGJzF5LFNtBBjMc79JPM7fbc1yNgLJ
	2BQ6y5fVfwkgX0r8mwLhVLxTZnk18ydFphfs0lpf0XnhW7STPPBkX3Ur
X-Gm-Gg: AfdE7cnxJtCWRhKW4zlzr3KFlZ+IOoAPfrczLnI1ttGCdaTtw0AsRfITyMN0VXJuK7K
	iaIx4w8ckZTCGg1E24N0yk6o4lxRyXZnhRPw0t2MllDnjqPL29hIKFR3iurGio+K9gaNcoPWGIx
	jr7/A/hQu6DhRr94lBDWlEjVv+0Ra6AEllCCbLZGbcuYxSRCq1zLTyGeBGL8+b4Zl9cIvpKN769
	zzZJ18zPSqb0urt47X0jfqIPsC3LN1srtmNzu7mqiPF3tsxTgvTOA4sMs/Wm4dqpCvbDcqzCKwl
	kt//Y14U0jA8OfYs3uO6UUPakTgtKTf3ejWnoj1fs5MNnrQ16RSv6aOxcqVuyBkQ2108dMqdYy1
	x0UTtx0ddv4iXJIySqimcQcZU1qegjrBJKgyq0DvSZ1lKZmY0+Aq4q6SZIcsO7VHAw+kdQYHPYt
	bnjklszaoQkXHRELtdBDy3ihsoq2YPHSN376PswAL1/MLRpp+ciluao5ui40yW
X-Received: by 2002:a05:600c:e547:20b0:490:3c15:7146 with SMTP id 5b1f17b1804b1-49238226380mr33567315e9.19.1781778751719;
        Thu, 18 Jun 2026 03:32:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa3a4easm266778845e9.3.2026.06.18.03.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:32:31 -0700 (PDT)
Date: Thu, 18 Jun 2026 11:32:29 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andreas Larsson <andreas@gaisler.com>
Cc: Andreas Larsson <andreas.larsson@gaisler.com>, Tony Rodriguez
 <unixpro1970@gmail.com>, davem@davemloft.net, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, thuth@redhat.com,
 regressions@lists.linux.dev, glaubitz@physik.fu-berlin.de
Subject: Re: [PATCH 1/1] sparc64: unify thread stack sizing and add explicit
 32KB stack
Message-ID: <20260618113229.7f1e51b3@pumpkin>
In-Reply-To: <d634e2f2-daf0-4328-bf16-7f5bff6fe851@gaisler.com>
References: <20260519075809.8993-1-unixpro1970@gmail.com>
	<20260519075809.8993-2-unixpro1970@gmail.com>
	<03111ac5-0055-425f-a7f2-54d4f2bb4988@gaisler.com>
	<20260616205851.428ca70c@pumpkin>
	<d634e2f2-daf0-4328-bf16-7f5bff6fe851@gaisler.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jun 2026 07:53:02 +0200
Andreas Larsson <andreas@gaisler.com> wrote:

> On 2026-06-16 21:58, David Laight wrote:
...
> > That whole logic is impenetrable.
> > Why not set the 'desired thread size' in kB, then work out how many
> > pages that ends up being based on the page size, and finally get the actual
> > stack size.
> > I'm not sure, but with vmalloc()ed stacks and 8k pages can't you have 24kB?  
> 
> No, the next step up is 32 KiB as the stack allocation is sized by
> THREAD_SIZE_ORDER.

Maybe, but there is probably no reason why that has to be the case.
I'm sure I've seem other architectures increasing the stack size by 4k.

	David

> 
> Cheers,
> Andreas
> 

