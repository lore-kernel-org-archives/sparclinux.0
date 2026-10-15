Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCD74C9DE6
	for <sparclinux@vger.kernel.org>; Thu, 15 Oct 2026 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062300; cv=pass; b=g5mSkns5kjE+DOenrV5QwGhv9qoHNdQLwpgMzBvrxyw3GCTb4QcC9qvIL0E+dsrbQqiDLkRWv066dthOLcr2N6G/76lTsW7crtpRUHiG1eFZf2IlaZAo47Kw94jHpPCjjK3nEG8fhx9evTahws3A8VEKm5Z3K3TOW7PvF3wuzmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062300; c=relaxed/simple;
	bh=XMmMyPDQ+TEEy7EW0hjPje5BHK38zbWBDk/kd5HUmro=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YX6TqeQVbxVZNe/7n2DHEOYolp65v1WaR4qSdaSszRrnI5Z5LG/CfZVH9v4ciGRtlxQIjvx9qv3bw74UWBrzlGgnOqydififMGBsb9/bVHsNzkqL2Mvl1pu8n0YyR9vfZOkm3YWoUgJkQ9CwNxSJEfBMqcRaGbbf5wGCz9QqnE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAdQZShL; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAdQZShL"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91b8b456dbeso41422216d6.2
        for <sparclinux@vger.kernel.org>; Thu, 15 Oct 2026 04:04:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792062298; cv=none;
        d=google.com; s=arc-20260327;
        b=lVFNJTNXMj2hxf5y36CcsMB3SsG5RUtm9cPwon0ZYaL1A2+APQibaRfio8Bdeky58V
         77rbBbBYpKY6lWRZhv+41qyeEZPnsiy6z/UnVvaEi5v+tI0SH9YEv2wPrrCK+OQoBXev
         1kT04aFnsblXVYo0hA6Qx7CHz2ycngRf1gKfgR45xGKC57W8MlfaAng4+lPiRwz0plSu
         viw+wVVdysa19b5fP4ktiXz6Dj6gNaw1vaLDQr81mkxhRElJfEgcAeaR6KEm9uhGaVjF
         FkE6MX+iqKRsV37ZMdSw/GEjejW5e89fPcKumT0+4086HliO5zMURTiErkxIFPUsUoZQ
         7ETg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=AvRJks4g5x0UaYHODzYIcmeJfpwAcs984u1aj11FO+0=;
        fh=XIDkWFFDh7ZrNdzTcaevcl8PRsQqq8MPex0OZcDNxn8=;
        b=ipZT2W5nH/3hp/EGyxfQaWB+kJy2hkPEfy1JQDkxC6K+XHyzTQik/Gf3HSXGrCZaxt
         e4dI3GvME+fNRi78xy9vP+iowblGYr2AgKQNLuQfKyJoc6d0x6iyeJgIBFDiNe086RJA
         LxMPDwoHyNArcjMzXPT3GqD+xpMRK0M/bips2tWixc1opiz2AY+zz9KqzHqQ1K2BVPK3
         F3tnobWvq82LCQgxH9WFOM+wGlvQwsA2gQntxSOLDNWvjmsmrJJubRFAwCuLqwVDQmfQ
         CV3mRRCGZ8Pbf3LNT5s0Dg7oq6dkKqdyAqK+oDQgHLFsOymNziWPuDNie8O+aM3N+E4W
         oqgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792062298; x=1792667098; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AvRJks4g5x0UaYHODzYIcmeJfpwAcs984u1aj11FO+0=;
        b=IAdQZShLFwBrJ+Q6U/bXFkG2Fg+YSPQ8LBk8d+Xbr528yHCsfHWKL3X7TQIzj5ciG1
         a2ikzHjR/A5q6nITNpyQ1f9iPOzbRNP5Tuuw/hbvILvNqM1y12Geg4XqaEv66umRoROk
         w4iVvM8VFUNaZNvAW2moVIGq3J7JVNWI+jQud8kABi4goOI/4tstU7SYrzUAT8BoJbVR
         WX3Su9Lrz+du4lET6r+9Su8GQAiOIv11+0U9B1lh0gbxCwagcIAlxbI42Z56RTMQtMUA
         eD3vT+qo3uV84sOPYXygkTZv3VEabAWiwWogCbiM54vRpHv3X35O6IeWkNm9TLCjmR24
         af0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792062298; x=1792667098;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AvRJks4g5x0UaYHODzYIcmeJfpwAcs984u1aj11FO+0=;
        b=0gmlAIxDTd0c8Ty8lX7JLx6LLer3MDthE7coby3shGXirxta4VGhSpFh8uflEhqZct
         +YVayO1mVf0qVYa383VY3omzwLExD9QzZYOwIt4abKwsAtZOBGvUZpAkFCJW7JyTHrMv
         PhuY26gGQUjxueRKLYj4nLJ7bHieQUYHxA1110++gOAKe41YLu8Ge9p08kclWjMtz4h2
         iNcRWBFrIBMOHfh6ijI2nnls2B4stmQ5m4cvacFAGqwqYz4lA+P1LWoqjXT/sxFVtDec
         g2+eZT0sU2a4HiWYV09pukXx6UoPSKh8UxSkoqD+PYdSx+kMTe7inL2WsCTrl4orVPfU
         pR/A==
X-Gm-Message-State: AFq9FYKZfhOVPIAdPRhgsH1EpVJVNHOLG5asOAFlzqnRx+jQtyenfSBq
	ZvYXe57EUX2rAHSASlSxgWfpUIkayRne5o7wWJvzhVyGZLbufPH1wnLo1QCtjv/RzsJRHG32aab
	azoQjVTIOdBSeWUKPoMkaawHsZ7bLJ3fahG7o
X-Gm-Gg: AYBFou3VVtRgbPjCMclwq96sYwT/a2hCrzeUmhQLj8UjAQ8e8BOaHghcACI/VM/p6G2
	2dgaMjxxnG7nOlSr0svKcITjyujVSFKjBZGmlRyh8CEn0qCziwhYYR5NF8cMp9lE9BD2hmF4/ca
	ngNb+MI5NZs24NEfoPV7gT8pa8E9BydclK4nvmxOQKxLS1dgdswwPakSYRHbPa5SW/qdqciC6WR
	3jzcLVGTQAMOeikTBA/rnpBfJhXHrjdQloupQk5NrjQuplk3fPl9aDHiNX5dNAzGQHz6pJClfaI
	HBJQDiNn2DIRxQgDqfpyd9Nq8XtSyfQ3HjjlqKDQk7MCbTkPeE+3N+NczFnRjsaKiblzWw==
X-Received: by 2002:a05:6214:d6b:b0:91b:8272:5157 with SMTP id
 6a1803df08f44-91b827252a6mr184737456d6.2.1792062297958; Thu, 15 Oct 2026
 04:04:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 15 Oct 2026 22:04:46 +1100
X-Gm-Features: AclHuK-nuoAUaKlXGbdwPMKlobo5_Yx1KCwcOT26HZUdz0A25JSIVXyhg4SqYdA
Message-ID: <CAGRGNgUXouKZ8VeVfyxMsph3uk27xxv18JqRx2aP+2DRjz395A@mail.gmail.com>
Subject: Giving away a big pile of Sparc hardware in Melbourne, Australia
To: sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm giving away all my Sparc hardware:

2x SparcStation 10s
1x Lunchbox form-factor 32-bit SparcStation, maybe an LX? Basically a
single processor SS10 in a lunchbox form factor with a microSparc CPU
1x Ultra 1e that doesn't boot with a graphics card
1x Ultra 5 with no cards or any other accessories

And a bunch of other random related stuff including some HDDs for the
Ultra1e, several sBus graphics cards, an sBus ESP wide SCSI card, some
random SCSI cabling and adapters, and an mBus HyperSparc CPU.

This is free to anyone who can either:
- collect it from the inner west of Melbourne
- or lives anywhere within ~15km of a line between the Melbourne and
Geelong CBDs that is accessible by car (if you're not sure, ask)

I'm not going to split this up, so if you don't want all of this,
please give away or recycle the rest.

I'll reply here when this is gone.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
