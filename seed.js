const { initializeApp } = require('firebase/app');
const { getFirestore, collection, addDoc, serverTimestamp, connectFirestoreEmulator } = require('firebase/firestore');

const firebaseConfig = {
  apiKey: "AIzaSyA0l25ANCqndPuRXOTJDgfFkTnprWRRE8c",
  authDomain: "aluinternship.firebaseapp.com",
  projectId: "aluinternship",
  storageBucket: "aluinternship.firebasestorage.app",
  messagingSenderId: "802794726298",
  appId: "1:802794726298:web:2a029b1f53ae377ce85023",
  measurementId: "G-B9VV3BEM71"
};

// Set to false to seed the live cloud Firestore instead of the local emulator.
const useLocalEmulator = false;

const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

if (useLocalEmulator) {
  connectFirestoreEmulator(db, '127.0.0.1', 8080);
  console.log('Connecting to local Firestore Emulator (127.0.0.1:8080) for seeding...');
}

const opportunities = [
  {
    title: 'Frontend Developer Intern',
    organization: 'Kigali HealthTech Startup',
    description: 'Work with our team to build responsive web interfaces using React and Tailwind CSS for a health records platform serving Rwandan clinics.',
    tags: ['Engineering', 'Remote', 'Frontend'],
    location: 'Remote',
    timeCommitment: 'Part-time',
    postedById: 'seed-script',
  },
  {
    title: 'Backend Engineering Intern (Node.js/Firebase)',
    organization: 'EduConnect Rwanda',
    description: 'Support development of REST APIs and Firestore data models powering an e-learning platform for secondary schools.',
    tags: ['Engineering', 'Kigali', 'Backend'],
    location: 'Kigali',
    timeCommitment: 'Full-time',
    postedById: 'seed-script',
  },
  {
    title: 'Mobile App Developer Intern (Flutter)',
    organization: 'AgriTrack',
    description: 'Help build and test features for a Flutter app that helps smallholder farmers track crop yields and market prices.',
    tags: ['Engineering', 'Remote', 'Flutter'],
    location: 'Remote',
    timeCommitment: 'Part-time',
    postedById: 'seed-script',
  },
  {
    title: 'QA/Testing Intern',
    organization: 'PayRwanda Fintech',
    description: 'Write and execute test cases for a mobile payments app, report bugs, and help improve our automated testing pipeline.',
    tags: ['Engineering', 'Kigali', 'QA'],
    location: 'Kigali',
    timeCommitment: 'Full-time',
    postedById: 'seed-script',
  },
  {
    title: 'DevOps Intern',
    organization: 'CloudNest Africa',
    description: 'Assist with CI/CD pipeline setup, containerization with Docker, and basic cloud infrastructure monitoring.',
    tags: ['Engineering', 'Remote', 'DevOps'],
    location: 'Remote',
    timeCommitment: 'Part-time',
    postedById: 'seed-script',
  },
  {
    title: 'UI/UX Design Intern',
    organization: 'Zuba Creative Studio',
    description: 'Design wireframes and high-fidelity prototypes in Figma for client mobile and web projects across East Africa.',
    tags: ['Design', 'Kigali', 'UI/UX'],
    location: 'Kigali',
    timeCommitment: 'Full-time',
    postedById: 'seed-script',
  },
  {
    title: 'Product Design Intern',
    organization: 'LinkUp ALU Alumni Platform',
    description: 'Collaborate with engineers and PMs to design user flows for an alumni networking and mentorship app.',
    tags: ['Design', 'Remote', 'Product'],
    location: 'Remote',
    timeCommitment: 'Part-time',
    postedById: 'seed-script',
  },
  {
    title: 'Graphic Design & Branding Intern',
    organization: 'Kigali Fashion Collective',
    description: 'Create branding assets, social media graphics, and lookbooks for emerging Rwandan fashion designers.',
    tags: ['Design', 'Kigali', 'Branding'],
    location: 'Kigali',
    timeCommitment: 'Part-time',
    postedById: 'seed-script',
  },
  {
    title: 'Motion Graphics Intern',
    organization: 'StreamAfrica Media',
    description: 'Produce short animated explainer videos and social content using After Effects for a growing media startup.',
    tags: ['Design', 'Remote', 'Motion'],
    location: 'Remote',
    timeCommitment: 'Part-time',
    postedById: 'seed-script',
  },
  {
    title: 'Social Media Marketing Intern',
    organization: 'GreenHarvest Agritech',
    description: 'Plan and schedule content across Instagram, TikTok, and X to grow awareness of sustainable farming products.',
    tags: ['Marketing', 'Remote', 'Social'],
    location: 'Remote',
    timeCommitment: 'Part-time',
    postedById: 'seed-script',
  },
  {
    title: 'Growth Marketing Intern',
    organization: 'Wano Delivery',
    description: 'Run referral campaigns and analyze user acquisition funnels for a last-mile delivery startup in Kigali.',
    tags: ['Marketing', 'Kigali', 'Growth'],
    location: 'Kigali',
    timeCommitment: 'Full-time',
    postedById: 'seed-script',
  },
  {
    title: 'Content Writer/Marketing Intern',
    organization: 'ALU Student Ventures',
    description: 'Write blog posts, newsletters, and case studies highlighting student-led startups across ALU campuses.',
    tags: ['Marketing', 'Remote', 'Content'],
    location: 'Remote',
    timeCommitment: 'Part-time',
    postedById: 'seed-script',
  },
  {
    title: 'Brand Partnerships Intern',
    organization: 'Kigali Startups Hub',
    description: 'Support outreach to potential sponsors and partners for community tech events and hackathons.',
    tags: ['Marketing', 'Kigali', 'Partnerships'],
    location: 'Kigali',
    timeCommitment: 'Full-time',
    postedById: 'seed-script',
  },
  {
    title: 'Data Analyst Intern',
    organization: 'RwandaStats Consulting',
    description: 'Clean and analyze survey datasets using Python/pandas, and build dashboards for client reporting.',
    tags: ['Data', 'Remote', 'Analytics'],
    location: 'Remote',
    timeCommitment: 'Part-time',
    postedById: 'seed-script',
  },
  {
    title: 'Machine Learning Intern (Malaria Prediction Project)',
    organization: 'HealthAI Rwanda',
    description: 'Support model development for predicting malaria outbreak risk using regional health and climate datasets.',
    tags: ['Data', 'Kigali', 'Machine Learning'],
    location: 'Kigali',
    timeCommitment: 'Full-time',
    postedById: 'seed-script',
  },
  {
    title: 'Business Intelligence Intern',
    organization: 'MicroFinance Plus',
    description: 'Build SQL queries and Power BI dashboards to track loan repayment trends for a microfinance institution.',
    tags: ['Data', 'Remote', 'BI'],
    location: 'Remote',
    timeCommitment: 'Part-time',
    postedById: 'seed-script',
  },
  {
    title: 'Data Entry & Cleaning Intern',
    organization: 'Census Support Unit',
    description: 'Assist in digitizing and validating household survey records ahead of a regional census initiative.',
    tags: ['Data', 'Kigali', 'Operations'],
    location: 'Kigali',
    timeCommitment: 'Full-time',
    postedById: 'seed-script',
  },
  {
    title: 'ALU Innovation Fellowship',
    organization: 'African Leadership University',
    description: 'A 6-month fellowship supporting student founders to develop early-stage ventures with mentorship and seed funding.',
    tags: ['Fellowships', 'Kigali', 'ALU'],
    location: 'Kigali',
    timeCommitment: 'Full-time',
    postedById: 'seed-script',
  },
  {
    title: 'Google Africa Developer Fellowship',
    organization: 'Google',
    description: 'A remote fellowship for student developers to build and ship a project with mentorship from Google engineers.',
    tags: ['Fellowships', 'Remote', 'Google'],
    location: 'Remote',
    timeCommitment: 'Full-time',
    postedById: 'seed-script',
  },
  {
    title: 'MEST Africa Entrepreneurship Fellowship',
    organization: 'MEST Africa',
    description: 'An intensive program teaching entrepreneurship, software development, and business fundamentals to early founders.',
    tags: ['Fellowships', 'Remote', 'Entrepreneurship'],
    location: 'Remote',
    timeCommitment: 'Full-time',
    postedById: 'seed-script',
  },
  {
    title: 'Mandela Washington Fellowship (Business Track)',
    organization: 'U.S. Embassy',
    description: 'A leadership fellowship for young African professionals focusing on business, civic leadership, and public management.',
    tags: ['Fellowships', 'Remote', 'Leadership'],
    location: 'Remote',
    timeCommitment: 'Full-time',
    postedById: 'seed-script',
  },
];

async function seed() {
  const colRef = collection(db, 'opportunities');
  console.log('Seeding started...');
  for (const op of opportunities) {
    op.postedAt = serverTimestamp();
    const docRef = await addDoc(colRef, op);
    console.log('Added document with ID: ', docRef.id);
  }
  console.log('Seeding finished successfully.');
  process.exit(0);
}

seed().catch(err => {
  console.error('Error seeding data: ', err);
  process.exit(1);
});
