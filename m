Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF454E73A7
	for <sparclinux@vger.kernel.org>; Thu, 17 Sep 2026 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660886; cv=none; b=YE2Fz/Dym47BUCcDMz+gwA+zqN8N01wPLiWi6vISrra4+szH6xsTtWI5cGyZQYMwzvu62OT6vSWDNwq0PGeF3pEwzBIF3NxdzBlrWdRB3W4oI0TfBKgSzRFu3wAaWVglBfPJ/FE5F6FDAvTTB7G/4n0l5HlRfhLkM3efYBqNodk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660886; c=relaxed/simple;
	bh=Zl7XEDEzyGFjQ8NnXy+A8Z96YlY800L0M+pR+Mfnr7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m506AS/DQmt3cF8ymQb1ENJKzvtOzOTKuJEnzsJ1G8Wwn9pkljRlZyzgVcDgVsBWILJH70iKP4alJyqvU/OedMrWi/2MuCStSlz7ZRCUX+txOl/WCj1AvqNOBQ9pxPP00rEED4ql8zopmMI9xCbY0Ju0XlUSzqrLHSU5EUWiHOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b3SGjnQa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3SGjnQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789660883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AxqSSuC6j5VlzBVquLjSQshKehqZsLbhTW+tuSGZqqk=;
	b=b3SGjnQaE/eT97eSayHaCdn57dIs0bi8f+fvnNROGasIFDfQn6rRKaRnxp/jfl9Hcx1M/i
	1Qw9/SJc/JScj6kZULdHHfn0qbSEBInIYZVwd3nVNJKWakAkaA8DHk7Yq2nWKM3vIoUCIC
	N36B44e8BJ/aDXZ16Gr4MkQty5wGihg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-rncYLlFTPy2Lq00Orktw_w-1; Thu,
 17 Sep 2026 12:01:19 -0400
X-MC-Unique: rncYLlFTPy2Lq00Orktw_w-1
X-Mimecast-MFC-AGG-ID: rncYLlFTPy2Lq00Orktw_w_1789660878
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD834193E8AD;
	Thu, 17 Sep 2026 16:01:17 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 860F018004D2;
	Thu, 17 Sep 2026 16:01:15 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Stian Halseth <stian@itx.no>
Cc: brauner@kernel.org,  viro@zeniv.linux.org.uk,  jack@suse.cz,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  sparclinux@vger.kernel.org,  schwab@suse.de
Subject: Re: [PATCH 0/2] fs: honor FOP_UNSIGNED_OFFSET in llseek and
 positional I/O
In-Reply-To: <20260917151614.376867-1-stian@itx.no> (Stian Halseth's message
	of "Thu, 17 Sep 2026 17:16:12 +0200")
References: <20260917151614.376867-1-stian@itx.no>
Date: Thu, 17 Sep 2026 18:01:13 +0200
Message-ID: <lhuo6dv50l2.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

* Stian Halseth:

> Tested on an UltraSPARC T4: pread(), preadv(), pwrite(), pwritev() and
> lseek() on /proc/PID/mem at positions above 2^63 return the correct data
> and offset; a negative position on a regular file or a pipe still fails
> with EINVAL and position 0 on a pipe with ESPIPE, as before; and the
> stock pldd(1) works again.  On other architectures the change is a no-op
> for every file without FOP_UNSIGNED_OFFSET, and userspace addresses
> never set the top bit, so the new paths are only reachable by passing
> a bogus position to /proc/PID/mem or /dev/mem, which then fails in the
> driver instead of the wrapper.

For lseek, aren't some file offsets (the top 4095 bytes or so just
before 2**64) ambiguous as error indicators?  You would have to use
_llseek when accessing /proc/PID/mem.

Thanks,
Florian

