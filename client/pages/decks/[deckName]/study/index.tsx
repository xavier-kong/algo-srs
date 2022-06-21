import { useRouter } from 'next/router';

const Study = () => {
    const router = useRouter();
    const { deckName } = router.query;
    return <div>Hello {deckName}</div>;
};

export default Study;
