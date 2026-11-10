Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304784;
	b=XIP7He74RXaNFja/3EVJhDz9b/qiIMRNHh8YaFqFqq90HPgVgfx5vKaMO0m87cWIdWSl
	 qe6Aj318QneT1o7poHOCJDKmhOT3mtWd0hQ8X8lSrg40Z3sDH3Lk+xnGB6mQDdB3H77am
	 MZquVRTsYctMFs5AUfSfklqKd3RWqjjYYY3MZtcZD90CErFuhpq49s3nbIxfaRCUfT94n
	 0HQ9PVptcrsL/CxvD0iXMpmNBrOs5QXeDvVGVKUIjobP/BO+kFP6qpSvoAlTBWb8XhePH
	 W3qzcTXXw6h5U97CtJ8UHn0ooSKMUS7QJFwp7BLzvFInpvsslaqpUVjTJgY/eAbZk0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304784;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wJOySXG09dMXLqdSSIWuOhORrXWnSA3N/YtRXqebW2s=;
	b=2HJrfXZ7A/gWpfveQTdQ+YBd1+A0EjUZfTQJ93ZGfyG4KQJhnxxfIotJSOq1GwlG/uBa
	 yQmbkkd8qjAY92N5c6elSudUetznzl5tJBPtcW/G6gWr180AJ6sNEbqigk2DCU5AO6Iro
	 CcHoS+vG+yLiICeuXvbrOJnZqUd3lyG8RMp3sufq0HXhNnC8KqHLcrF5RWmNhUTAn0448
	 PWQJGxQHUheu4PDz1JpO8ZEcTMK+0gZyqlXtzE06VCTBOA8qTGApnAXjadLLoxZUzNB92
	 aiYndaujkpwJcBiN7wr36nSm6puSHPE5fJHDGEZPvv+Bigf+m3LvyhETD35kjgh2bLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sr8AcXcQ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sPqnSeoi;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311C0606A321
	for <sparclinux@vger.kernel.org>; Tue, 10 Nov 2026 09:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 311C0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sr8AcXcQ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sPqnSeoi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794304782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJOySXG09dMXLqdSSIWuOhORrXWnSA3N/YtRXqebW2s=;
	b=Sr8AcXcQs/idA572AS4kHK5mkBfqbzDUhsVXooXETEkLQUhNdhAjrrhn1qTbuC+1RLV99Y
	3t9yLwAtfBq1GB52cSdNh84FMArl5mXWzx0Qsvx8gDze9t56Fu08T5o0AUqJnET7cvToqF
	KOJIb4WneTE/JXNiB/eY8Nt9kDXrIBo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-4IWThlGjOSOr2F42XY511Q-1; Tue, 10 Nov 2026 04:59:41 -0500
X-MC-Unique: 4IWThlGjOSOr2F42XY511Q-1
X-Mimecast-MFC-AGG-ID: 4IWThlGjOSOr2F42XY511Q_1794304780
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a318cd95e8so14602435e9.0
        for <sparclinux@vger.kernel.org>; Tue, 10 Nov 2026 01:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794304780; x=1794909580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJOySXG09dMXLqdSSIWuOhORrXWnSA3N/YtRXqebW2s=;
        b=sPqnSeoi4vhi9k/Qk8upVc9av02O7XT2MLDS0rt0xhyMHyAOJTROqdLihjJ+H2zx6n
         frm0rtCZ2oIBy/C6ZHHpV2ob4KNI+PdWmcdWFh82/mVEmIN3CPH8Q+HhXpLubBaC4oBt
         oGJ0Ur1aYmxQqQpLEJGwhdWDUj/iJ0tP6tYm0BglzC+ZKE5E3qnCOP5O6zxLAIRdmmkG
         HN75xD4GDthIjKj6G45ZFnBSqwTeabEWIumblhGmjUKx8YhN7a73AxdkDrxW2XrP/ZZ3
         fGc6IR5e8EIgEe+03M1/3pUnLm2t/25VcRxYCteAYP1w1vIESf+zMfBEeEOHgzMLAp6v
         3gjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794304780; x=1794909580;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wJOySXG09dMXLqdSSIWuOhORrXWnSA3N/YtRXqebW2s=;
        b=hG89v8RjLtDH5f/CcMaEraXoRbli0TvdabLejiigR48WM/CkgwKuDbot4m5amLYHMn
         anxG4U3f8ALr0/vU+NFBlLonvQfzmEtUVspapGWuusUBnOFskXgz6bFcR6ouQzwLx0M2
         GkwimrChvBLnG9ElkJK6J9IrVLi71bLthLpMpGrgA/8HOElj8qi6v2F5X7Co1EmzBSnc
         1faJUnNJ8hsIP6rLCoWyM3/tA21A6j/6FC5RhDa57emiglys5LL00c90iSGxU4EcIhsZ
         EWT/svZh8q2CC+y91vj7330OF586iEp0DjdtRg4ahRK0ieRj6K7XzjnwG9D5Pr22Dw9I
         M/nw==
X-Forwarded-Encrypted: i=1; AL+hErEGb6UKI4txYx6Fn0jU3hY1wb+NkhZnu5Bs1/w8wumaPQIy8TXM3/n+vLAY0Ro3rIxfUphObQ0DDvQI@vger.kernel.org
X-Gm-Message-State: APuU4Z9hY9cPT+F7piIoejpWxd+9NK44XUurR1d5RJs/IedNAAh6dS9p
	xCykZbX1DOwtH1I/Ha03HaN2VbLmDIM9nSelS9ohnrZGgFQBKVLRJO6SMPdCV9p3/G/WYdhHb9u
	v7v4kCy+2QXjYtrXPhSkTCKRAevmYpizshroJ5QOMK8A6iX1fOHx3KtvlOy0fISo=
X-Gm-Gg: AYBFou3DLtKZut6ddD4oC2VGHqYH04Tjt0+x829y/XFhGInNw5ZpGnf1B5Sj6CgCMot
	Ln3Q4HM+YUJzcRaZuHHeHSI6lErZMZA449sqYCDBqFtIbuzQDIHnQcz9AmkUSNd6EVAuk8RZ9+P
	Z4VKq69ratpI/AKVpe9pWPCg5egkCD8ti04l1InBRMJTgYJA7Q67fhAWninehtKhfIaaV1tf3c+
	kd90x1OQGeJS5DYnR/GZwe+ufa19UR7mAMWlQ16iaADHDsCHDtzRf4YKYzluXv2kjpx0bsV2cY/
	2oF5NaXKsFAghm6YCsOxdbapbi2g5eCsWWWuo4lveiutDSvJj5+AODn16aD3w9aHdgW748+wre6
	ZllHCSh8pMXTE8g+DQHNCQHxqERY7JGq20L8of6/rDtQm9cFupoqQdtOe1C2GDMZ86oWPeKunGf
	b4pqDQZnmi6aHmm186cHWuS6HMxlx813Lzluiv7gjWrpws
X-Received: by 2002:a05:600c:4e0d:b0:4ba:cd:f45a with SMTP id 5b1f17b1804b1-4ba0234ee12mr34932755e9.14.1794304779730;
        Tue, 10 Nov 2026 01:59:39 -0800 (PST)
X-Received: by 2002:a05:600c:4e0d:b0:4ba:cd:f45a with SMTP id 5b1f17b1804b1-4ba0234ee12mr34932105e9.14.1794304779321;
        Tue, 10 Nov 2026 01:59:39 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba022fbf75sm44329265e9.0.2026.11.10.01.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 01:59:38 -0800 (PST)
Message-ID: <c3e7afde-65ac-48e2-a89b-9fc1ad42aa87@redhat.com>
Date: Tue, 10 Nov 2026 10:59:36 +0100
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: add SO_PASSCRED_THREAD to get a
 thread-specific SCM_CREDENTIALS
To: Andrew Halaney <andrew@amutable.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Willem de Bruijn <willemb@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
References: <20261102-halaney-scm-creds-thread-v1-0-0b4d75dbf35f@amutable.com>
 <20261102-halaney-scm-creds-thread-v1-2-0b4d75dbf35f@amutable.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261102-halaney-scm-creds-thread-v1-2-0b4d75dbf35f@amutable.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/26 00:12, Andrew Halaney wrote:
> diff --git a/net/core/sock.c b/net/core/sock.c
> index e7405be8941f..6b443bd44581 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1586,6 +1586,13 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>   			ret = -EOPNOTSUPP;
>   		break;
>   
> +	case SO_PASSCRED_THREAD:
> +		if (sk_is_unix(sk))
> +			sk->sk_scm_credentials_thread = valbool;
> +		else
> +			ret = -EOPNOTSUPP;
> +		break;

AF_UNIX supports custom setsockopt since commit
de1c489b57c11fabc766aeb6777ed5b0038fa3bb

I think it would be better to move add the af unix specific ones
into net/unix/af_unix.c.

But that is IMHO more suited for a follow-up; the series LGTM,
thanks.

Paolo

